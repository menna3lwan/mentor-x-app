import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'products_grid', route: const MarketplaceGridRoute()),
    (
      name: 'product_detail',
      route: const MarketplaceDetailRoute(itemId: '1'),
    ),
    (name: 'shopping_cart', route: const MarketplaceCartRoute()),
    (name: 'order_history', route: const MarketplaceOrdersRoute()),
    (name: 'wallet_add_balance', route: const AddBalanceRoute()),
    (name: 'wallet_redeem_code', route: const RedeemCodeRoute()),
    (
      name: 'wallet_purchase_confirm',
      route: const PurchaseConfirmRoute(paymentId: '1'),
    ),
    (name: 'wallet_payment_success', route: const PaymentSuccessRoute()),
    (
      name: 'wallet_transactions_history',
      route: const TransactionsHistoryRoute(),
    ),
    (name: 'rewards_catalog', route: const RewardsCatalogRoute()),
    (name: 'rewards_history', route: const RewardsHistoryRoute()),
  ];

  for (final entry in routes) {
    patrolTest('Student commerce page smoke: ${entry.name}', ($) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
