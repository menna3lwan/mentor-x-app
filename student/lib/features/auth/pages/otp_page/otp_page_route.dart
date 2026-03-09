part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<OtpPageRoute>(path: '/otp', name: 'otp')
final class OtpPageRoute extends GoRouteData with $OtpPageRoute {
  final String phoneNumber;
  final int? otpLength;
  final int? otpDurationSeconds;

  const OtpPageRoute({
    required this.phoneNumber,
    this.otpLength,
    this.otpDurationSeconds,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OtpPageBloc>(
      create: (context) => OtpPageBloc(
        authRepository: context.read<StudentAuthenticationRepository>(),
        phoneNumber: phoneNumber,
        otpLength: otpLength,
        otpDuration: otpDurationSeconds != null
            ? Duration(seconds: otpDurationSeconds!)
            : null,
      ),
      child: const OtpPageWrapper(),
    );
  }
}
