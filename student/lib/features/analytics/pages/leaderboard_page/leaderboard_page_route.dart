part of '../../../../core/routing/app_routes.dart';

final class LeaderboardPageRoute extends GoRouteData {
  final String? courseId;
  const LeaderboardPageRoute({this.courseId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LeaderboardPageWrapper(courseId: courseId);
  }
}
