import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  final routes = <({String name, GoRouteData route})>[
    (name: 'products_grid', route: const ProductsGridPageRoute()),
    (name: 'product_detail', route: const ProductDetailPageRoute(itemId: '1')),
    (name: 'shopping_cart', route: const ShoppingCartPageRoute()),
    (name: 'order_history', route: const OrderHistoryPageRoute()),
    (name: 'wallet_add_balance', route: const AddBalancePageRoute()),
    (name: 'wallet_redeem_code', route: const RedeemCodePageRoute()),
    (name: 'wallet_purchase_confirm', route: const PurchaseConfirmPageRoute()),
    (name: 'wallet_payment_success', route: const PaymentSuccessPageRoute()),
    (
      name: 'wallet_transactions_history',
      route: const TransactionsHistoryPageRoute(),
    ),
    (name: 'rewards_catalog', route: const RewardsCatalogPageRoute()),
    (name: 'rewards_history', route: const RewardsHistoryPageRoute()),
  ];

  for (final entry in routes) {
    patrolTest('Student commerce page smoke: ${entry.name}', ($) async {
      await launchStudentApp($);
      await goToStudentRoute($, entry.route);
    });
  }
}
