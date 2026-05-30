import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';
import 'package:parent/features/features.dart';

final class ForgetPasswordPageWrapper extends StatefulWidget {
  const ForgetPasswordPageWrapper({super.key});

  @override
  State<ForgetPasswordPageWrapper> createState() =>
      _ForgetPasswordPageWrapperState();
}

class _ForgetPasswordPageWrapperState extends State<ForgetPasswordPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<
      ForgetPasswordBloc,
      ForgetPasswordPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ForgetPasswordSuccessPresentationEvent(:final phone):
            _openResetPasswordBottomSheet(phone);
          case ForgetPasswordFailurePresentationEvent(:final exception):
            MentorXUI.showToast(
              message: _failureMessage(exception, t),
              isError: true,
            );
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.select<ForgetPasswordBloc, bool>(
            (bloc) => bloc.state.loadingState.isLoading,
          );
          return Form(
            key: _formKey,
            child: ForgetPasswordPage(
              title: t.auth.forgotPasswordTitle,
              subtitle: t.auth.forgotPasswordSubtitle,
              phoneField: MentorXTextFormField(
                label: t.auth.phoneNumberLabel,
                hintText: t.auth.phoneNumberHint,
                icon: Icons.phone_android_rounded,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.auth.phoneRequired;
                  }
                  return null;
                },
              ),
              sendCodeButton: MentorXButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ForgetPasswordBloc>().add(
                            ForgetPasswordSubmittedEvent(
                              phoneNumber: _phoneController.text,
                            ),
                          );
                        }
                      },
                label: t.auth.sendVerificationCode,
                loading: isLoading,
              ),
              backToLoginButton: TextButton(
                onPressed: () => const LoginPageRoute().go(context),
                child: Text(
                  t.auth.backToLogin,
                  style: TextStyle(
                    color: context.brandPrimaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Maps backend exception codes to localized user-facing copy so the toast
  /// always says something meaningful regardless of upstream wording.
  String _failureMessage(
    MentorXException exception,
    TranslationsParentEn t,
  ) {
    if (exception is AuthenticationException) {
      return switch (exception.code) {
        AuthenticationExceptionCode.networkError => t.unableToLoad,
        AuthenticationExceptionCode.failedToSendOtp ||
        AuthenticationExceptionCode.failedToRequestPasswordReset =>
          t.auth.sendCodeFailed,
        _ => exception.message ?? t.auth.sendCodeFailed,
      };
    }
    return exception.message ?? t.auth.sendCodeFailed;
  }

  Future<void> _openResetPasswordBottomSheet(String phone) async {
    final t = Translations.of(context).parent;
    final otpController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    bool isSubmitting = false;

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              decoration: BoxDecoration(
                color: sheetContext.backgroundPrimaryColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: sheetContext.textTertiaryColor.withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Gap(32),
                    Text(
                      t.auth.resetPasswordTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: sheetContext.textPrimaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      t.auth.resetPasswordSubtitle(phone: phone),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: sheetContext.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const Gap(40),
                    MentorXTextFormField(
                      label: t.auth.otpCodeLabel,
                      hintText: t.auth.otpFieldHint,
                      icon: Icons.verified_rounded,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                    const Gap(20),
                    MentorXTextFormField(
                      label: t.auth.newPasswordLabel,
                      hintText: t.auth.passwordPlaceholder,
                      icon: Icons.lock_rounded,
                      controller: newPasswordController,
                      isPassword: true,
                    ),
                    const Gap(20),
                    MentorXTextFormField(
                      label: t.auth.confirmPasswordLabel,
                      hintText: t.auth.passwordPlaceholder,
                      icon: Icons.lock_reset_rounded,
                      controller: confirmPasswordController,
                      isPassword: true,
                    ),
                    const Gap(40),
                    MentorXButton(
                      onPressed: isSubmitting
                          ? null
                          : () async {
                              final otp = otpController.text.trim();
                              final newPassword = newPasswordController.text;
                              final confirmPassword =
                                  confirmPasswordController.text;

                              if (otp.length < 4 ||
                                  newPassword.length < 8 ||
                                  newPassword != confirmPassword) {
                                MentorXUI.showToast(
                                  message: t.auth.validationCheckInputs,
                                  isError: true,
                                );
                                return;
                              }

                              setModalState(() => isSubmitting = true);
                              try {
                                await this.context
                                    .read<AuthenticationRepository>()
                                    .resetPassword(
                                      phone: phone,
                                      otp: otp,
                                      newPassword: newPassword,
                                    );
                                if (!sheetContext.mounted) return;
                                Navigator.pop(sheetContext, true);
                              } catch (e) {
                                MentorXUI.showToast(
                                  message: e.toString(),
                                  isError: true,
                                );
                              } finally {
                                setModalState(() => isSubmitting = false);
                              }
                            },
                      label: t.auth.updatePasswordNow,
                      loading: isSubmitting,
                    ),
                    const Gap(16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result == true) {
      MentorXUI.showToast(message: t.auth.passwordResetSuccess);
      if (!mounted) return;
      const LoginPageRoute().go(context);
    }
  }
}
