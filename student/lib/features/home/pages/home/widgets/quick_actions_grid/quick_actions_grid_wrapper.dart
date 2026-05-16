import 'package:flutter/material.dart';

import 'quick_actions_grid_widget.dart';

final class QuickActionsGrid extends StatelessWidget {
  final ValueChanged<int>? onActionTap;

  const QuickActionsGrid({super.key, this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return QuickActionsGridWidget(onActionTap: onActionTap);
  }
}
