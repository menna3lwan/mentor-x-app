part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<RedeemCodeRoute>(path: '/redeem-code', name: 'redeemCode')
final class RedeemCodeRoute extends GoRouteData with $RedeemCodeRoute {
  const RedeemCodeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<RedeemCodeBloc>(
      create: (context) => RedeemCodeBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const RedeemCodeLoadEvent()),
      child: const RedeemCodePageWrapper(),
    );
  }
}
