part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PurchaseConfirmPageRoute>(
  path: '/purchase-confirm/:paymentId',
  name: 'purchaseConfirm',
)
final class PurchaseConfirmPageRoute extends GoRouteData
    with $PurchaseConfirmPageRoute {
  final String paymentId;
  const PurchaseConfirmPageRoute({required this.paymentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PurchaseConfirmPageBloc>(
      create: (context) => PurchaseConfirmPageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(PurchaseConfirmPageLoadEvent(paymentId: paymentId)),
      child: const PurchaseConfirmPageWrapper(),
    );
  }
}
