part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<OtpPageRoute>(path: '/otp', name: 'otp')
final class OtpPageRoute extends GoRouteData with $OtpPageRoute {
  final String? phone;
  const OtpPageRoute({this.phone});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<OtpBloc>(
      create: (context) => OtpBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: OtpPageWrapper(phone: phone ?? ""),
    );
  }
}
