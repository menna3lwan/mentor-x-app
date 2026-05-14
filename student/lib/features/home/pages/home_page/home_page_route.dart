part of '../../../../core/routing/app_routes.dart';

final class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = context.read<AppAuthenticationCubit>().state;
    return BlocProvider<HomePageBloc>(
      create: (context) => HomePageBloc(
        homeRepository: context.read<StudentHomeRepository>(),
        analyticsService: context.read<AnalyticsService>(),
        studentName: (user?.fullName ?? 'Student').trim(),
        avatarUrl: user?.profileImageUrl,
      )..add(const HomePageInitializedEvent()),
      child: const HomePageWrapper(),
    );
  }
}
