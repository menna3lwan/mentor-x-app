part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RegistrationPageRoute>(path: '/register', name: 'register')
final class RegistrationPageRoute extends GoRouteData
    with $RegistrationPageRoute {
  const RegistrationPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => StudentRegistrationBloc(
        registrationRepository: context.read<StudentRegistrationRepository>(),
        tenantId: '1',
      )..add(const StudentRegistrationBootstrapRequested()),
      child: const RegistrationPageWrapper(),
    );
  }
}
