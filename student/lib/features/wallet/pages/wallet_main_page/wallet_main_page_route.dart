part of '../../../../core/routing/app_routes.dart';

final class WalletMainPageRoute extends GoRouteData with $WalletMainPageRoute {
  const WalletMainPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<WalletMainPageBloc>(
      create: (context) => WalletMainPageBloc(
        walletRepository: context.read<WalletRepository>(),
      )..add(const WalletMainPageLoadEvent()),
      child: const WalletMainPageWrapper(),
    );
  }
}
