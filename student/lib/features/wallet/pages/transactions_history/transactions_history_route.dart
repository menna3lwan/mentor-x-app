part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<TransactionsHistoryRoute>(
  path: '/transactions-history',
  name: 'transactionsHistory',
)
final class TransactionsHistoryRoute extends GoRouteData
    with $TransactionsHistoryRoute {
  const TransactionsHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<TransactionsHistoryBloc>(
      create: (context) => TransactionsHistoryBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const TransactionsHistoryLoadEvent()),
      child: const TransactionsHistoryPageWrapper(),
    );
  }
}
