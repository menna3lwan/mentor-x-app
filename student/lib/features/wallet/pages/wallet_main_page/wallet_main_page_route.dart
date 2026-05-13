part of '../../../../core/routing/app_routes.dart';

final class WalletMainPageRoute extends GoRouteData with $WalletMainPageRoute {
  const WalletMainPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalletMainPageBloc>(
      create: (context) => WalletMainPageBloc(
        walletRepository: context.read<WalletRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const WalletMainPageLoadEvent()),
      child: const WalletMainPageWrapper(),
    );
  }
}
