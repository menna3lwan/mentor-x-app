part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AddBalancePageRoute>(path: '/add-balance', name: 'addBalance')
final class AddBalancePageRoute extends GoRouteData with $AddBalancePageRoute {
  const AddBalancePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AddBalancePageBloc>(
      create: (context) => AddBalancePageBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AddBalancePageLoadEvent()),
      child: const AddBalancePageWrapper(),
    );
  }
}
