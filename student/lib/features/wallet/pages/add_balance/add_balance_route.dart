part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<AddBalanceRoute>(path: '/add-balance', name: 'addBalance')
final class AddBalanceRoute extends GoRouteData with $AddBalanceRoute {
  const AddBalanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AddBalanceBloc>(
      create: (context) => AddBalanceBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const AddBalanceLoadEvent()),
      child: const AddBalancePageWrapper(),
    );
  }
}
