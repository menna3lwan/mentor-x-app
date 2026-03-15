part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<TransactionsHistoryPageRoute>(
  path: '/transactions-history',
  name: 'transactionsHistory',
)
final class TransactionsHistoryPageRoute extends GoRouteData
    with $TransactionsHistoryPageRoute {
  const TransactionsHistoryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<TransactionsHistoryPageBloc>(
      create: (context) => TransactionsHistoryPageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const TransactionsHistoryPageLoadEvent()),
      child: const TransactionsHistoryPageWrapper(),
    );
  }
}
