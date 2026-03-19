part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<TenantSelectionPageRoute>(
  path: '/tenant-selection',
  name: 'tenant-selection',
)
final class TenantSelectionPageRoute extends GoRouteData
    with $TenantSelectionPageRoute {
  const TenantSelectionPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TenantSelectionPage(
      cacheRepository: context.read<CacheRepository>(),
    );
  }
}
