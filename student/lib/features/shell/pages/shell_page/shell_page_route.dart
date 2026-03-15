part of '../../../../core/routing/app_routes.dart';

// ─── Branch data classes (required by @TypedStatefulShellRoute) ────────────
final class HomeShellBranchData extends StatefulShellBranchData {}

final class CoursesShellBranchData extends StatefulShellBranchData {}

final class QuizzesShellBranchData extends StatefulShellBranchData {}

final class WalletShellBranchData extends StatefulShellBranchData {}

final class ProfileShellBranchData extends StatefulShellBranchData {}

@TypedStatefulShellRoute<ShellPageRoute>(
  branches: [
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: [
        TypedGoRoute<HomePageRoute>(path: '/', name: 'home'),
      ],
    ),
    TypedStatefulShellBranch<CoursesShellBranchData>(
      routes: [
        TypedGoRoute<MyCoursesPageRoute>(
          path: '/my-courses',
          name: 'myCourses',
        ),
      ],
    ),
    TypedStatefulShellBranch<QuizzesShellBranchData>(
      routes: [
        TypedGoRoute<QuizListPageRoute>(path: '/quiz-list', name: 'quizList'),
      ],
    ),
    TypedStatefulShellBranch<WalletShellBranchData>(
      routes: [
        TypedGoRoute<WalletMainPageRoute>(path: '/wallet', name: 'walletMain'),
      ],
    ),
    TypedStatefulShellBranch<ProfileShellBranchData>(
      routes: [
        TypedGoRoute<ProfileViewPageRoute>(
          path: '/profile',
          name: 'profileView',
        ),
      ],
    ),
  ],
)
final class ShellPageRoute extends StatefulShellRouteData {
  const ShellPageRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return BlocProvider<ShellPageBloc>(
      create: (_) => ShellPageBloc()..add(const ShellPageLoadEvent()),
      child: ShellPageWrapper(navigationShell: navigationShell),
    );
  }
}
