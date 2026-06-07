part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RegistrationRoute>(path: '/register', name: 'register')
final class RegistrationRoute extends GoRouteData
    with $RegistrationRoute {
  const RegistrationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => StudentRegistrationBloc(
        registrationRepository: context.read<StudentRegistrationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        tenantId: '1',
      )..add(const StudentRegistrationBootstrapRequested()),
      child: const RegistrationPageWrapper(),
    );
  }
}
