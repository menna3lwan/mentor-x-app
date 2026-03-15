part of '../../../../core/routing/app_routes.dart';

final class HomePageRoute extends GoRouteData with $HomePageRoute {
  const HomePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = context.read<AppAuthenticationCubit>().state;
    return BlocProvider<HomePageBloc>(
      create: (context) => HomePageBloc(
        homeRepository: context.read<StudentHomeRepository>(),
        studentName: (user?.name ?? 'Student').trim(),
      )..add(const HomePageInitializedEvent()),
      child: const HomePageWrapper(),
    );
  }
}
