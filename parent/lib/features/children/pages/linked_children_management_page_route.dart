part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<LinkedChildrenManagementPageRoute>(
  path: '/children',
  name: 'parent_children',
)
final class LinkedChildrenManagementPageRoute extends GoRouteData
    with $LinkedChildrenManagementPageRoute {
  const LinkedChildrenManagementPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ChildrenBloc>(
      create: (context) =>
          ChildrenBloc(repository: context.read<ParentPortalRepository>())
            ..add(const ChildrenStarted()),
      child: const LinkedChildrenManagementPage(),
    );
  }
}
