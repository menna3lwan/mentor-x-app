part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<SupportPageRoute>(path: '/support', name: 'support')
final class SupportPageRoute extends GoRouteData with $SupportPageRoute {
  const SupportPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SupportPageBloc>(
      create: (context) => SupportPageBloc()..add(const SupportPageLoadEvent()),
      child: const SupportPageWrapper(),
    );
  }
}
