part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PaymentSuccessPageRoute>(
  path: '/payment-success',
  name: 'paymentSuccess',
)
final class PaymentSuccessPageRoute extends GoRouteData
    with $PaymentSuccessPageRoute {
  const PaymentSuccessPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PaymentSuccessPageBloc>(
      create: (context) =>
          PaymentSuccessPageBloc()..add(const PaymentSuccessPageLoadEvent()),
      child: const PaymentSuccessPageWrapper(),
    );
  }
}
