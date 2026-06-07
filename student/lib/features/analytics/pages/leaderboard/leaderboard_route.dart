part of '../../../../core/routing/app_routes.dart';

final class LeaderboardRoute extends GoRouteData
    with $LeaderboardRoute {
  final String? courseId;
  const LeaderboardRoute({this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LeaderboardPageWrapper(courseId: courseId);
  }
}
