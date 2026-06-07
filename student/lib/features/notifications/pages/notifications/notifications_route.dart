part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<NotificationsRoute>(
  path: '/notifications',
  name: 'notifications',
)
final class NotificationsRoute extends GoRouteData
    with $NotificationsRoute {
  const NotificationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<NotificationsBloc>(
      create: (context) => NotificationsBloc(
        notificationRepository: context.read<NotificationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const NotificationsLoadEvent()),
      child: const NotificationsPageWrapper(),
    );
  }
}
