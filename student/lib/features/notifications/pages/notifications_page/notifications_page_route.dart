part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<NotificationsPageRoute>(
  path: '/notifications',
  name: 'notifications',
)
final class NotificationsPageRoute extends GoRouteData
    with $NotificationsPageRoute {
  const NotificationsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<NotificationsPageBloc>(
      create: (context) => NotificationsPageBloc(
        notificationRepository: context.read<NotificationRepository>(),
      )..add(const NotificationsPageLoadEvent()),
      child: const NotificationsPageWrapper(),
    );
  }
}
