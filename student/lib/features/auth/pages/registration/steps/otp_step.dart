import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../bloc/student_registration_bloc.dart';

final class OtpStep extends StatelessWidget {
  const OtpStep({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final bloc = context.read<StudentRegistrationBloc>();

    final defaultPinTheme = PinTheme(
      width: 52,
      height: 64,
      textStyle: TextStyle(
        fontSize: 24,
        color: context.textPrimaryColor,
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
          width: 2,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: context.brandPrimaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );

    return Builder(
      builder: (context) {
        final phone = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.phone,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Icon(
                  Icons.mark_chat_read_rounded,
                  size: 64,
                  color: context.brandPrimaryColor,
                ),
              ),
            ),
            const Gap(32),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: Text(
                t['otpVerifyTitle'] ?? 'Verification Code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const Gap(12),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: context.textSecondaryColor,
                    fontSize: 15,
                    height: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text:
                          '${t['otpSentWhatsapp'] ?? "We've sent a 6-digit code to"}\n',
                    ),
                    TextSpan(
                      text: phone,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(48),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                separatorBuilder: (index) => const Gap(8),
                onChanged: (v) => bloc.add(StudentRegistrationOtpChanged(v)),
              ),
            ),
            const Gap(40),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${t['didNotReceiveCode'] ?? "Didn't receive a code?"} ',
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        bloc.add(const StudentRegistrationResendOtpRequested()),
                    child: Text(
                      t['resendCode'] ?? 'Resend',
                      style: TextStyle(
                        color: context.brandPrimaryColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
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
