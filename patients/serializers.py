from rest_framework import serializers
from .models import Patient

class PatientSerializer(serializers.ModelSerializer):
    survey_status = serializers.SerializerMethodField()
    risk_level = serializers.SerializerMethodField()

    class Meta:
        model = Patient
        fields = '__all__'
        # allow client to send patient_id (server will also generate if not provided)
        read_only_fields = ['doctor']

    def get_survey_status(self, obj):
        survey = obj.surveys.order_by('-created_at').first()
        if not survey or not survey.status:
            return "Not Started"
        
        val = survey.status.lower()
        if val in ["postoperative", "completed"]:
            return "Completed"
        elif val == "not_completed":
            return "Not Started"
        else:
            return "Pending"

    def get_risk_level(self, obj):
        survey = obj.surveys.order_by('-created_at').first()
        if not survey or not survey.risk_level:
            return "N/A"
        return survey.risk_level

    def validate(self, data):
        doctor = self.context['request'].user
        instance = getattr(self, 'instance', None)

        # Use existing patient_id if not provided in request (for updates)
        patient_id = data.get('patient_id', None)
        if not patient_id and instance:
            patient_id = instance.patient_id

        if not patient_id:
            # Creating without provided patient_id -> server will generate; skip uniqueness check now
            return data

        qs = Patient.objects.filter(doctor=doctor, patient_id=patient_id)
        if instance:
            qs = qs.exclude(pk=instance.pk)

        if qs.exists():
            raise serializers.ValidationError({
                "patient_id": "This patient_id already exists for this doctor."
            })

        return data
