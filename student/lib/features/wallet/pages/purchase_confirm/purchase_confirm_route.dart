part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PurchaseConfirmRoute>(
  path: '/purchase-confirm/:paymentId',
  name: 'purchaseConfirm',
)
final class PurchaseConfirmRoute extends GoRouteData
    with $PurchaseConfirmRoute {
  final String paymentId;
  const PurchaseConfirmRoute({required this.paymentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PurchaseConfirmBloc>(
      create: (context) => PurchaseConfirmBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(PurchaseConfirmLoadEvent(paymentId: paymentId)),
      child: const PurchaseConfirmPageWrapper(),
    );
  }
}
