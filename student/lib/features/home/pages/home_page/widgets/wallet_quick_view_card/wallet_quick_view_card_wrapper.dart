import 'package:flutter/material.dart';

import 'package:mentorx_core/mentorx_core.dart';
import 'wallet_quick_view_card_widget.dart';

final class WalletQuickViewCard extends StatelessWidget {
  final WalletSummaryEntity? walletSummary;
  final bool isLoading;

  const WalletQuickViewCard({
    super.key,
    required this.walletSummary,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return WalletQuickViewCardWidget(
      walletSummary: walletSummary,
      isLoading: isLoading,
    );
  }
}
