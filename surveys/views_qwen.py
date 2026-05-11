from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django.shortcuts import get_object_or_404

from patients.models import Patient
from surveys.models import Survey
from llm.inference import generate
from llm.prompt_builder import build_ppc_prompt


class PPCQwenChatView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        doctor = request.user
        patient_id = request.data.get("patient_id")
        question = request.data.get("question")

        if not patient_id or not question:
            return Response(
                {"error": "patient_id and question are required"},
                status=400
            )

        # ✅ doctor can access ONLY own patients
        patient = get_object_or_404(
            Patient,
            patient_id=patient_id,
            doctor=doctor
        )

        survey = (
            Survey.objects
            .filter(patient=patient)
            .order_by("-created_at")
            .first()
        )

        if not survey:
            return Response(
                {
                    "error": "Medical data missing",
                    "debug": f"No completed survey found for Patient {patient_id}. Please submit a survey for this patient first."
                },
                status=404
            )

        try:
            prompt = build_ppc_prompt(
                patient=patient,
                survey=survey,
                section_scores=survey.section_scores.all(),
                answers=survey.answers.all(),
                question=question
            )

            answer = generate(prompt)

            if not answer or answer.strip() == "":
                return Response({
                    "error": "Model generated empty response",
                    "debug": "The AI model did not generate a valid response. Please try again."
                }, status=500)

            return Response({
                "success": True,
                "patient_id": patient.patient_id,
                "risk_level": survey.risk_level,
                "total_score": survey.total_score,
                "answer": answer
            })
        
        except Exception as e:
            import logging
            logger = logging.getLogger(__name__)
            logger.error(f"Qwen model error: {str(e)}", exc_info=True)
            
            return Response({
                "error": "Unable to generate response from model",
                "debug": str(e)
            }, status=500)
