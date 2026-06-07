part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<SettingsListRoute>(path: '/settings', name: 'settingsList')
final class SettingsListRoute extends GoRouteData
    with $SettingsListRoute {
  const SettingsListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<SettingsListBloc>(
      create: (context) => SettingsListBloc(
        settingsRepository: context.read<SettingsRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const SettingsListLoadEvent()),
      child: const SettingsListPageWrapper(),
    );
  }
}
