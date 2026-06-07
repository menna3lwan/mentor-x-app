part of '../../../../core/routing/app_routes.dart';

final class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = context.read<AppAuthenticationCubit>().state;
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        homeRepository: context.read<StudentHomeRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        studentName: user != null
            ? '${user.firstName} ${user.secondName ?? ''}'.trim()
            : 'Student',
        avatarUrl: user?.profileImageUrl,
      )..add(const HomeInitializedEvent()),
      child: const HomePageWrapper(),
    );
  }
}
