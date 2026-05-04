part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<VerifyIdentityPageRoute>(path: '/verify-identity')
final class VerifyIdentityPageRoute extends GoRouteData with $VerifyIdentityPageRoute {
  const VerifyIdentityPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => VerifyIdentityPageBloc(
        repository: context.read<StudentProfileRepository>(),
      )..add(const VerifyIdentityPageStarted()),
      child: const VerifyIdentityPageWrapper(),
    );
  }
}
