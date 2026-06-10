import 'dart:async';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../../core/core.dart';

import 'bloc/otp_bloc.dart';
import 'otp_page.dart';

class OtpPageWrapper extends StatefulWidget {
  final String phoneNumber;
  const OtpPageWrapper({super.key, required this.phoneNumber});

  @override
  State<OtpPageWrapper> createState() => _OtpPageWrapperState();
}

class _OtpPageWrapperState extends State<OtpPageWrapper> {
  final _otpController = TextEditingController();
  final _logger = MentorXLogger('OtpPageWrapper');

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => OtpBloc(
        authenticationRepository: context
            .read<AuthenticationRepository<ParentEntity>>(),
      ),
      child: BlocPresentationListener<OtpBloc, OtpPresentationEvent>(
        listener: (context, event) {
          switch (event) {
            case OtpSuccessPresentationEvent(:final user):
              // Persist the authenticated user before navigating so the rest
              // of the app sees the new session.
              _logger.info(
                '🟢 [OTP_PAGE_WRAPPER] OtpSuccessPresentationEvent received: user=${user.fullName}, id=${user.id}',
              );
              _logger.info(
                '🟢 [OTP_PAGE_WRAPPER] Calling AppAuthenticationCubit.login(user)...',
              );
              context.read<AppAuthenticationCubit>().login(user);
              _logger.info(
                '🟢 [OTP_PAGE_WRAPPER] AppAuthenticationCubit.login() completed. Now calling _handleSuccessNavigation()...',
              );
              unawaited(_handleSuccessNavigation(context));
            case OtpFailurePresentationEvent(:final exception):
              // Clear the bad code on invalid-OTP so the user can retry
              // without re-tapping the field.
              if (exception is AuthenticationException &&
                  exception.code == AuthenticationExceptionCode.invalidOtp) {
                _otpController.clear();
              }
              MentorXUI.showToast(
                message: _errorMessage(exception, t),
                isError: true,
              );
          }
        },
        child: Builder(
          builder: (context) {
            final state = context.watch<OtpBloc>().state;
            final bloc = context.read<OtpBloc>();

            return OtpPage(
              backButton: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
              ),
              title: Text(
                t.auth.otpTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
              subtitle: Text(
                t.auth.otpSubtitle(phone: widget.phoneNumber),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: context.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              otpFields: MentorXTextFormField(
                controller: _otpController,
                label: t.auth.otpFieldLabel,
                hintText: t.auth.otpFieldHint,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 6,
                icon: Icons.lock_clock_rounded,
                autofillHints: const [AutofillHints.oneTimeCode],
                // Digit-only + safe clipboard paste.
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                onChanged: (value) {
                  _logger.info(
                    '🟣 [OTP_PAGE_WRAPPER] OTP field changed; length=${value.length}, loading=${state.loadingState.isLoading}',
                  );
                  if (value.length == 6 && !state.loadingState.isLoading) {
                    _logger.info(
                      '🟢 [OTP_PAGE_WRAPPER] Auto-submit triggered from OTP field change',
                    );
                    bloc.add(
                      OtpSubmittedEvent(
                        phone: widget.phoneNumber,
                        code: value,
                      ),
                    );
                  }
                },
              ),
              verifyButton: MentorXButton(
                label: t.auth.verifyAndContinue,
                onPressed:
                    state.loadingState.isLoading ||
                        _otpController.text.length < 6
                    ? null
                    : () {
                        _logger.info(
                          '🟢 [OTP_PAGE_WRAPPER] Verify button clicked; submitting OTP length=${_otpController.text.length}',
                        );
                        bloc.add(
                          OtpSubmittedEvent(
                            phone: widget.phoneNumber,
                            code: _otpController.text,
                          ),
                        );
                      },
                loading: state.loadingState.isLoading,
              ),
              resendButton: TextButton(
                onPressed: state.canResend && !state.isResending
                    ? () => bloc.add(
                        OtpResendRequested(phone: widget.phoneNumber),
                      )
                    : null,
                child: Text(
                  state.isResending
                      ? t.auth.resending
                      : state.canResend
                      ? t.auth.resendCode
                      : t.auth.resendInSeconds(
                          seconds: state.resendCountdown,
                        ),
                  style: TextStyle(
                    color: state.canResend
                        ? context.brandPrimaryColor
                        : context.textTertiaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Maps an [AuthenticationException] code to a localized user-facing
  /// message. Falls back to a generic "verification failed" copy.
  String _errorMessage(
    MentorXException exception,
    TranslationsParentEn t,
  ) {
    if (exception is AuthenticationException) {
      return switch (exception.code) {
        AuthenticationExceptionCode.invalidOtp => t.auth.verificationFailed,
        AuthenticationExceptionCode.networkError => t.unableToLoad,
        AuthenticationExceptionCode.failedToResendOtp => t.auth.sendCodeFailed,
        _ => exception.message ?? t.auth.verificationFailed,
      };
    }
    return exception.message ?? t.auth.verificationFailed;
  }

  Future<void> _handleSuccessNavigation(BuildContext context) async {
    _logger.info('🟢 [OTP_PAGE_WRAPPER] _handleSuccessNavigation START');
    final childrenRepo = context.read<ParentChildrenRepository>();
    try {
      _logger.info('🟢 [OTP_PAGE_WRAPPER] Fetching children list...');
      final children = await childrenRepo.getChildren();
      _logger.info(
        '🟢 [OTP_PAGE_WRAPPER] Children fetched: ${children.length} children',
      );
      if (!context.mounted) {
        _logger.warning(
          '🟡 [OTP_PAGE_WRAPPER] Context not mounted after children fetch',
        );
        return;
      }
      if (children.isEmpty) {
        _logger.info(
          '🟢 [OTP_PAGE_WRAPPER] No children linked, navigating to AddChildLinkRoute',
        );
        const AddChildLinkRoute().go(context);
      } else {
        _logger.info(
          '🟢 [OTP_PAGE_WRAPPER] Children exist, navigating to HomePageRoute',
        );
        const HomePageRoute().go(context);
      }
    } catch (e) {
      _logger.error(
        '🔴 [OTP_PAGE_WRAPPER] Error fetching children: $e, navigating to HomePageRoute anyway',
      );
      if (context.mounted) {
        const HomePageRoute().go(context);
      }
    }
    _logger.info('🟢 [OTP_PAGE_WRAPPER] _handleSuccessNavigation END');
  }
}
