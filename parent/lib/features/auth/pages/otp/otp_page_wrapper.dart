import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';

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
        authenticationRepository:
            context.read<AuthenticationRepository<ParentEntity>>(),
      ),
      child: BlocPresentationListener<OtpBloc, OtpPresentationEvent>(
        listener: (context, event) {
          switch (event) {
            case OtpSuccessPresentationEvent():
              _handleSuccessNavigation(context);
            case OtpFailurePresentationEvent(:final exception):
              MentorXUI.showToast(
                message: exception.message ?? t.auth.verificationFailed,
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
                maxLength: 6,
                icon: Icons.lock_clock_rounded,
                onChanged: (value) {
                  if (value.length == 6) {
                    bloc.add(OtpSubmittedEvent(
                      phone: widget.phoneNumber,
                      code: value,
                    ));
                  }
                },
              ),
              verifyButton: MentorXButton(
                label: t.auth.verifyAndContinue,
                onPressed: state.loadingState.isLoading ||
                        _otpController.text.length < 6
                    ? null
                    : () {
                        bloc.add(OtpSubmittedEvent(
                          phone: widget.phoneNumber,
                          code: _otpController.text,
                        ));
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

  Future<void> _handleSuccessNavigation(BuildContext context) async {
    final childrenRepo = context.read<ParentChildrenRepository>();
    try {
      final children = await childrenRepo.getChildren();
      if (!context.mounted) return;
      if (children.isEmpty) {
        const AddChildLinkRoute().go(context);
      } else {
        const HomePageRoute().go(context);
      }
    } catch (_) {
      if (context.mounted) {
        const HomePageRoute().go(context);
      }
    }
  }
}
