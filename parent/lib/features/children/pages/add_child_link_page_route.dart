part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AddChildLinkPageRoute>(
  path: '/children/add',
  name: 'parent_children_add',
)
final class AddChildLinkPageRoute extends GoRouteData
    with $AddChildLinkPageRoute {
  const AddChildLinkPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<ChildrenBloc>(
      create: (context) =>
          ChildrenBloc(repository: context.read<ParentPortalRepository>())
            ..add(const ChildrenStarted()),
      child: const AddChildLinkPage(),
    );
  }
}
