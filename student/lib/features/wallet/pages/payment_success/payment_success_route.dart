part of '../../../../core/routing/app_routes.dart';

@TypedGoRoute<PaymentSuccessRoute>(
  path: '/payment-success',
  name: 'paymentSuccess',
)
final class PaymentSuccessRoute extends GoRouteData
    with $PaymentSuccessRoute {
  final String? amount;
  const PaymentSuccessRoute({this.amount});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<PaymentSuccessBloc>(
      create: (context) => PaymentSuccessBloc(
        analyticsService: context.read<AnalyticsService>(),
      )..add(const PaymentSuccessLoadEvent()),
      child: PaymentSuccessPageWrapper(amount: amount),
    );
  }
}
