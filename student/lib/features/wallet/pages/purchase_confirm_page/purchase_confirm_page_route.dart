part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PurchaseConfirmPageRoute>(
  path: '/purchase-confirm',
  name: 'purchaseConfirm',
)
final class PurchaseConfirmPageRoute extends GoRouteData
    with $PurchaseConfirmPageRoute {
  const PurchaseConfirmPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PurchaseConfirmPageBloc>(
      create: (context) => PurchaseConfirmPageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const PurchaseConfirmPageLoadEvent()),
      child: const PurchaseConfirmPageWrapper(),
    );
  }
}
