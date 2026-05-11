from django.http import Http404
from rest_framework import generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.shortcuts import get_object_or_404
from .models import Survey, Patient
from .serializers import CompletedPatientSerializer, PendingPatientSerializer, SurveySectionRiskSerializer, SurveySerializer, SurveyDisplaySerializer, DashboardSerializer
from rest_framework.views import APIView

class SurveyCreateView(generics.CreateAPIView):
    queryset = Survey.objects.all()
    serializer_class = SurveySerializer
    permission_classes = [IsAuthenticated]

# --------------------  survey completed list --------------------
class PatientCompletedSurveys(generics.ListAPIView):
    serializer_class = CompletedPatientSerializer
    permission_classes = [IsAuthenticated]

    def list(self, request, *args, **kwargs):
        doctor = request.user

        surveys = Survey.objects.filter(
            patient__doctor=doctor,          # 🔐 FIX
            status__iexact="postoperative"
        ).select_related("patient").order_by("-created_at")

        data = []

        for survey in surveys:
            patient = survey.patient

            photo_url = None
            if patient.photo:
                scheme = 'https' if request.is_secure() else 'http'
                host = request.get_host()
                photo_url = f"{scheme}://{host}{patient.photo.url}"

            data.append({
                "pk": patient.id,
                "id": patient.patient_id,
                "name": patient.name,
                "status": "Completed",
                "survey_status": "Completed",
                "risk_level": survey.risk_level,
                "photoUrl": photo_url
            })

        return Response(data)


    
# --------------------  survey not completed list --------------------
class PatientNotCompletedSurveys(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        doctor = request.user
        patients = Patient.objects.filter(doctor=doctor).order_by('-created_at')
        pending_patients = []

        for patient in patients:
            # Get latest survey for patient
            survey = Survey.objects.filter(patient=patient).order_by("-created_at").first()

            # Build full photo URL if exists
            photo_url = None
            if patient.photo:
                scheme = 'https' if request.is_secure() else 'http'
                host = request.get_host()
                photo_url = f"{scheme}://{host}{patient.photo.url}"

            # Determine status
            status_text = "Not Started"
            if survey and survey.status:
                val = survey.status.lower()
                if val in ["postoperative", "completed"]:
                    status_text = "Completed"
                elif val == "not_completed":
                    status_text = "Not Started"
                else:
                    status_text = "Pending"

            # Only include pending surveys (not postoperative)
            if not survey or survey.status.lower() != "postoperative":
                patient_dict = {
                    "pk": patient.id,
                    "id": patient.patient_id,
                    "name": patient.name,
                    "status": status_text,
                    "survey_status": status_text,
                    "risk_level": survey.risk_level if survey and survey.risk_level else "N/A",
                    "photo": photo_url
                }
                pending_patients.append(patient_dict)

        return Response(pending_patients)



class SurveyStatsView(generics.GenericAPIView):
    def get(self, request, *args, **kwargs):
        total_completed = Survey.objects.filter(status="completed").count()
        total_not_completed = Survey.objects.filter(status="not_completed").count()
        return Response({
            "completed": total_completed,
            "not_completed": total_not_completed
        })

class SurveyByPatientView(generics.RetrieveAPIView):
    serializer_class = SurveyDisplaySerializer
    def get_object(self):
        patient_id = self.kwargs.get("patient_id")
        patient = get_object_or_404(Patient, id=patient_id)
        # ✅ return single Survey row per patient
        return Survey.objects.filter(patient=patient).first()



class SurveyByPatientWithRiskView(generics.RetrieveAPIView):
    serializer_class = SurveySectionRiskSerializer
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        patient_id = self.kwargs.get("patient_id")
        patient = get_object_or_404(Patient, id=patient_id)
        survey = Survey.objects.filter(patient=patient).first()
        if not survey:
            return Response({"detail": "No survey found"}, status=404)

        # Prepare section scores
        section_data = []
        risk_level = survey.risk_level.lower() if survey.risk_level else "low"
        risk_dict = {
            "low": "Standard anesthesia; routine monitoring.",
            "moderate": "Lung-protective ventilation, multimodal analgesia, encourage early mobilization.",
            "high": "Prefer regional if feasible, strict lung-protective strategy, consider postoperative ICU/HDU.",
            "very high": "Strongly consider avoiding GA/ETT if possible; optimize comorbidities pre-op, mandatory ICU planning."
        }

        for section in survey.section_scores.all():
            section_data.append({
                "section_name": section.section_name,
                "score": section.score,
                "risk_advice": risk_dict.get(risk_level, "Standard anesthesia; routine monitoring.")
            })

        return Response(section_data)
    
#---------------------Dashboard view for pie chart---------------------
class DashboardView(generics.GenericAPIView):
    serializer_class = DashboardSerializer
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        doctor = request.user
        patients = Patient.objects.filter(doctor=doctor)

        total_patients = patients.count()

        pending_surveys = 0
        high_risk_patients = 0
        surveyed_count = 0
        
        low_risk_count = 0
        moderate_risk_count = 0
        high_risk_pie_count = 0

        for patient in patients:
            latest_survey = Survey.objects.filter(patient=patient).order_by("-created_at").first()

            if not latest_survey or latest_survey.status.lower() != "postoperative":
                pending_surveys += 1
            else:
                surveyed_count += 1
                risk = latest_survey.risk_level.lower() if latest_survey.risk_level else "low"
                
                if risk in ["high", "very high"]:
                    high_risk_patients += 1
                    high_risk_pie_count += 1
                elif risk == "moderate":
                    moderate_risk_count += 1
                else:
                    low_risk_count += 1

        total_for_pie = low_risk_count + moderate_risk_count + high_risk_pie_count or 1

        data = {
            # dashboard counts
            "total_surveyed": surveyed_count,
            "pending_surveys": pending_surveys,
            "high_risk_patients": high_risk_patients,
            "total_patients": total_patients,

            # pie chart counts
            "stable": low_risk_count,        # Mapped to Low Risk in iOS app
            "pending": moderate_risk_count,  # Mapped to Moderate in iOS app
            "high_risk": high_risk_pie_count,# Mapped to High Risk in iOS app
        }

        serializer = self.get_serializer(data)
        return Response(serializer.data)

# -------------------- High Risk / Completed Patients with Risk --------------------
class HighRiskPatients(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        doctor = request.user

        surveys = Survey.objects.filter(
            patient__doctor=doctor,           # 🔐 FIX
            status__iexact="postoperative",
            risk_level__in=["High", "Very High"]
        ).select_related("patient").order_by("-created_at")

        data = []

        for survey in surveys:
            patient = survey.patient

            photo_url = None
            if patient.photo:
                scheme = 'https' if request.is_secure() else 'http'
                host = request.get_host()
                photo_url = f"{scheme}://{host}{patient.photo.url}"

            data.append({
                "pk": patient.id,
                "id": patient.patient_id,
                "name": patient.name,
                "photoUrl": photo_url,
                "risk_level": survey.risk_level,
                "status": "Completed",
                "survey_status": "Completed"
            })

        return Response(data)



class SurveySectionAnswersView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, patient_id):
        section_name = request.query_params.get("section", "")
        if not section_name:
            return Response({"error": "Section name required"}, status=400)

        patient = get_object_or_404(Patient, id=patient_id)
        survey = Survey.objects.filter(patient=patient).order_by("-created_at").first()

        if not survey:
            return Response({"answers": []})

        # Filter answers only for the given section
        answers = survey.answers.filter(section_name=section_name)

        return Response({
            "answers": [
                {"question": a.question, "selected_option": a.selected_option}
                for a in answers
            ]
        })
