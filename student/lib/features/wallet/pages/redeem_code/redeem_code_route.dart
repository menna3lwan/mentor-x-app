part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RedeemCodePageRoute>(path: '/redeem-code', name: 'redeemCode')
final class RedeemCodePageRoute extends GoRouteData with $RedeemCodePageRoute {
  const RedeemCodePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<RedeemCodePageBloc>(
      create: (context) => RedeemCodePageBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const RedeemCodePageLoadEvent()),
      child: const RedeemCodePageWrapper(),
    );
  }
}
