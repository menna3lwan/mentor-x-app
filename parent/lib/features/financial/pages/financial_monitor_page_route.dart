part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<FinancialMonitorPageRoute>(
  path: '/financial/monitor',
  name: 'parent_financial_monitor',
)
final class FinancialMonitorPageRoute extends GoRouteData
    with $FinancialMonitorPageRoute {
  const FinancialMonitorPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<FinancialBloc>(
      create: (context) =>
          FinancialBloc(repository: context.read<ParentPortalRepository>())
            ..add(const FinancialStarted()),
      child: const FinancialMonitorPage(),
    );
  }
}
