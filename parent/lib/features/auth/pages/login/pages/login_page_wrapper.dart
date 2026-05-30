import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../../../core/routing/app_routes.dart';
import '../bloc/login_bloc.dart';
import '../login_page.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: context
            .read<AuthenticationRepository<ParentEntity>>(),
        deviceInfoService: context.read<DeviceInfoService>(),
      ),
      child: const _LoginPageView(),
    );
  }
}

/// Listens for presentation events fired by [LoginBloc] (success / OTP /
/// failure) and runs the corresponding side effect — login, OTP redirect, or
/// localized toast. Keeps the UI page itself purely visual.
class _LoginPageView extends StatelessWidget {
  const _LoginPageView();

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<LoginBloc, LoginPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case LoginSuccessPresentationEvent(:final user):
            context.read<AppAuthenticationCubit>().login(user);
            const HomePageRoute().go(context);
          case LoginOtpRequiredPresentationEvent(:final phoneNumber):
            OtpPageRoute(phoneNumber: phoneNumber).go(context);
          case LoginFailurePresentationEvent(:final exception):
            MentorXUI.showToast(
              message: _messageFor(context, exception),
              isError: true,
            );
        }
      },
      child: const LoginPage(),
    );
  }

  /// Maps an [AuthenticationException] code to a localized user-facing
  /// message. Keeps API codes out of the presentation layer.
  String _messageFor(BuildContext context, MentorXException exception) {
    final t = Translations.of(context).parent;
    if (exception is AuthenticationException) {
      return switch (exception.code) {
        AuthenticationExceptionCode.invalidCredentials => t.auth.loginFailed,
        AuthenticationExceptionCode.networkError => t.unableToLoad,
        AuthenticationExceptionCode.sessionExpired => t.auth.loginFailed,
        _ => exception.message ?? t.auth.loginFailed,
      };
    }
    return exception.message ?? t.auth.loginFailed;
  }
}
