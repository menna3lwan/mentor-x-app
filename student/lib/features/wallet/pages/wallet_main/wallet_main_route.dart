part of '../../../../core/routing/app_routes.dart';

final class WalletMainRoute extends GoRouteData with $WalletMainRoute {
  const WalletMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalletMainBloc>(
      create: (context) => WalletMainBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const WalletMainLoadEvent()),
      child: const WalletMainPageWrapper(),
    );
  }
}
