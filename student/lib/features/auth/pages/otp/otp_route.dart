part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<OtpRoute>(path: '/otp', name: 'otp')
final class OtpRoute extends GoRouteData with $OtpRoute {
  final String phoneNumber;
  final int? otpLength;
  final int? otpDurationSeconds;

  const OtpRoute({
    required this.phoneNumber,
    this.otpLength,
    this.otpDurationSeconds,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OtpBloc>(
      create: (context) => OtpBloc(
        authRepository: context.read<StudentAuthenticationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
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
