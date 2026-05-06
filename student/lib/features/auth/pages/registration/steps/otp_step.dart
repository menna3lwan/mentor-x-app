import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import '../bloc/student_registration_bloc.dart';

class OtpStep extends StatelessWidget {
  const OtpStep({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final bloc = context.read<StudentRegistrationBloc>();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: palette.textPrimary,
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: palette.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: palette.textTertiary.withValues(alpha: 0.1),
          width: 2,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: palette.brandPrimary, width: 2),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );

    return BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: palette.brandPrimary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_read_outlined,
                  size: 64,
                  color: palette.brandPrimary,
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: Text(
                t['otpVerifyTitle'] ?? 'Verification Code',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: palette.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: Text(
                '${t['otpSentWhatsapp'] ?? "We've sent a 6-digit code to"}\n${state.phone}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: palette.textSecondary,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                onChanged: (v) => bloc.add(StudentRegistrationOtpChanged(v)),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${t['didNotReceiveCode'] ?? "Didn't receive a code?"} ',
                    style: TextStyle(
                      color: palette.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        bloc.add(const StudentRegistrationResendOtpRequested()),
                    child: Text(
                      t['resendCode'] ?? 'Resend',
                      style: TextStyle(
                        color: palette.brandPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}
