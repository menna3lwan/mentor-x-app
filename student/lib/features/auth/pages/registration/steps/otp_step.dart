import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../bloc/student_registration_bloc.dart';

final class OtpStep extends StatelessWidget {
  const OtpStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentRegistrationBloc>();

    final defaultPinTheme = PinTheme(
      width: 52,
      height: 64,
      textStyle: context.titleH2Style.copyWith(
        fontSize: 24,
        color: context.textPrimaryColor,
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: MentorXGlassCard(
                  style: Style(
                    $box.width(120),
                    $box.height(120),
                    $box.borderRadius(60),
                    $box.color(
                      context.brandPrimaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.mark_chat_read_rounded,
                      size: 64,
                      color: context.brandPrimaryColor,
                    ),
                  ),
                ),
              ),
              const Gap(32),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: Text(
                  context.t.auth.otpVerifyTitle,
                  style: context.titleH1Style.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
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
                    style: context.bodySecondaryStyle.copyWith(
                      color: context.textSecondaryColor,
                      fontSize: 15,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: '${context.t.auth.otpSentWhatsapp}\n',
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
                      "${context.t.auth.didNotReceiveCode} ",
                      style: context.bodySecondaryStyle.copyWith(
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => bloc.add(
                        const StudentRegistrationResendOtpRequested(),
                      ),
                      child: Text(
                        context.t.auth.resendCode,
                        style: context.bodySecondaryStyle.copyWith(
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
          ),
        );
      },
    );
  }
}
