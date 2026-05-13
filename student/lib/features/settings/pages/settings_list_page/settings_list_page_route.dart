part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<SettingsListPageRoute>(path: '/settings', name: 'settingsList')
final class SettingsListPageRoute extends GoRouteData
    with $SettingsListPageRoute {
  const SettingsListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SettingsListPageBloc>(
      create: (context) => SettingsListPageBloc(
        settingsRepository: context.read<SettingsRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const SettingsListPageLoadEvent()),
      child: const SettingsListPageWrapper(),
    );
  }
}
