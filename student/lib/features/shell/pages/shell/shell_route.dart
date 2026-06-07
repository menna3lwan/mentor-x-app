part of '../../../../core/routing/app_routes.dart';

// ─── Branch data classes (required by @TypedStatefulShellRoute) ────────────
final class HomeShellBranchData extends StatefulShellBranchData {}

final class CoursesShellBranchData extends StatefulShellBranchData {}

final class QuizzesShellBranchData extends StatefulShellBranchData {}

final class WalletShellBranchData extends StatefulShellBranchData {}

final class ProfileShellBranchData extends StatefulShellBranchData {}

@TypedStatefulShellRoute<ShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: '/',
          name: 'home',
          routes: [
            TypedGoRoute<AnnouncementsRoute>(
              path: 'announcements',
            ),
            TypedGoRoute<AnalyticsDashboardRoute>(
              path: 'analytics',
              routes: [
                TypedGoRoute<LeaderboardRoute>(path: 'leaderboard'),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<CoursesShellBranchData>(
      routes: [
        TypedGoRoute<MyCoursesRoute>(
          path: '/my-courses',
          name: 'myCourses',
        ),
      ],
    ),
    TypedStatefulShellBranch<QuizzesShellBranchData>(
      routes: [
        TypedGoRoute<QuizListRoute>(path: '/quiz-list', name: 'quizList'),
      ],
    ),
    TypedStatefulShellBranch<WalletShellBranchData>(
      routes: [
        TypedGoRoute<WalletMainRoute>(path: '/wallet', name: 'walletMain'),
      ],
    ),
    TypedStatefulShellBranch<ProfileShellBranchData>(
      routes: [
        TypedGoRoute<ProfileViewRoute>(
          path: '/profile',
          name: 'profileView',
        ),
      ],
    ),
  ],
)
final class ShellRoute extends StatefulShellRouteData {
  const ShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return BlocProvider<ShellBloc>(
      create: (context) => ShellBloc(
        analyticsService: context.read<AnalyticsService>(),
      )..add(const ShellLoadEvent()),
      child: ShellPageWrapper(navigationShell: navigationShell),
    );
  }
}
