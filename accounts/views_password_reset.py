from django.core.mail import EmailMultiAlternatives
from django.utils import timezone
from django.conf import settings
from django.template.loader import render_to_string
from django.utils.html import strip_tags

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import AllowAny
from accounts.serializers import ForgotPasswordSerializer
import datetime

from .models import Doctor
from .serializers import (
    ForgotPasswordSerializer,
    VerifyOtpSerializer,
    ResetPasswordWithOtpSerializer,
)

OTP_EXPIRY_MINUTES = 10


class ForgotPasswordView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = ForgotPasswordSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        identifier = serializer.validated_data["identifier"]

        # find user
        try:
            if "@" in identifier:
                user = Doctor.objects.get(email__iexact=identifier)
            else:
                user = Doctor.objects.get(username__iexact=identifier)
        except Doctor.DoesNotExist:
            return Response({"message": "If account exists, OTP sent"}, status=200)

        # generate OTP
        otp = user.generate_otp()
        
        # Log to console for development
        print(f"\n[RESET PASSWORD] OTP for {user.username} ({user.email}): {otp}\n")

        # send email in background thread to avoid timeout
        import threading
        def send_otp_email():
            subject = "🔒 Your POPC Password Reset Code"
            
            # Premium HTML Email Template
            html_content = f"""
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="utf-8">
                <style>
                    body {{ font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f9; margin: 0; padding: 0; }}
                    .container {{ max-width: 600px; margin: 40px auto; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }}
                    .header {{ background: linear-gradient(135deg, #0052D4, #4364F7, #6FB1FC); padding: 40px 20px; text-align: center; color: #ffffff; }}
                    .header h1 {{ margin: 0; font-size: 28px; font-weight: 600; letter-spacing: 1px; }}
                    .content {{ padding: 40px 30px; text-align: center; color: #333333; }}
                    .content p {{ font-size: 16px; line-height: 1.6; color: #555555; }}
                    .otp-container {{ margin: 30px 0; padding: 20px; background-color: #f8f9fa; border: 2px dashed #4364F7; border-radius: 8px; display: inline-block; }}
                    .otp-code {{ font-size: 42px; font-weight: 700; color: #4364F7; letter-spacing: 8px; margin: 0; }}
                    .expiry {{ font-size: 14px; color: #888888; font-style: italic; margin-top: 10px; }}
                    .footer {{ padding: 20px; text-align: center; font-size: 12px; color: #aaaaaa; background-color: #fdfdfd; border-top: 1px solid #eeeeee; }}
                    .footer a {{ color: #4364F7; text-decoration: none; }}
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>POPC Healthcare</h1>
                    </div>
                    <div class="content">
                        <h2>Reset Your Password</h2>
                        <p>We received a request to reset your password. Use the following Verification Code to complete the process:</p>
                        <div class="otp-container">
                            <h1 class="otp-code">{otp}</h1>
                        </div>
                        <p class="expiry">This code is valid for <strong>{OTP_EXPIRY_MINUTES} minutes</strong>. If you didn't request this, you can safely ignore this email.</p>
                    </div>
                    <div class="footer">
                        <p>&copy; {datetime.datetime.now().year} POPC Healthcare Team. All rights reserved.</p>
                        <p>Need help? <a href="#">Contact Support</a></p>
                    </div>
                </div>
            </body>
            </html>
            """
            
            text_content = f"Your POPC Verification Code is: {otp}. Valid for {OTP_EXPIRY_MINUTES} minutes."
            
            try:
                msg = EmailMultiAlternatives(subject, text_content, settings.DEFAULT_FROM_EMAIL, [user.email])
                msg.attach_alternative(html_content, "text/html")
                msg.send(fail_silently=False)
                print(f"DEBUG: Email successfully sent to {user.email}")
            except Exception as e:
                print(f"ERROR: Failed to send email: {e}")
        
        threading.Thread(target=send_otp_email).start()

        return Response({"message": "OTP sent to registered email"}, status=200)


class VerifyOtpView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = VerifyOtpSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        identifier = serializer.validated_data["identifier"]
        otp = serializer.validated_data["otp"]

        try:
            if "@" in identifier:
                user = Doctor.objects.get(email__iexact=identifier)
            else:
                user = Doctor.objects.get(username__iexact=identifier)
        except Doctor.DoesNotExist:
            return Response({"error": "Invalid OTP"}, status=400)

        # check OTP
        if user.reset_otp != otp:
            return Response({"error": "Invalid OTP"}, status=400)

        # expiry check
        if user.reset_otp_created < timezone.now() - datetime.timedelta(minutes=OTP_EXPIRY_MINUTES):
            return Response({"error": "OTP expired"}, status=400)

        return Response({"message": "OTP verified"}, status=200)


class ResetPasswordWithOtpView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        serializer = ResetPasswordWithOtpSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        identifier = serializer.validated_data["identifier"]
        otp = serializer.validated_data["otp"]
        new_password = serializer.validated_data["new_password"]

        try:
            if "@" in identifier:
                user = Doctor.objects.get(email__iexact=identifier)
            else:
                user = Doctor.objects.get(username__iexact=identifier)
        except Doctor.DoesNotExist:
            return Response({"error": "Invalid request"}, 400)

        if user.reset_otp != otp:
            return Response({"error": "Invalid OTP"}, 400)

        if user.reset_otp_created < timezone.now() - datetime.timedelta(minutes=OTP_EXPIRY_MINUTES):
            return Response({"error": "OTP expired"}, 400)

        # reset password
        user.set_password(new_password)
        user.reset_otp = None
        user.save()

        return Response({"message": "Password updated successfully"}, status=200)
