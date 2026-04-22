import 'package:flutter/material.dart';

class ParentQuickActionsGrid extends StatelessWidget {
  const ParentQuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _QuickActionItem(
              icon: Icons.assignment_outlined,
              label: 'Attendance',
              color: Colors.blue,
              onTap: () {},
            ),
            _QuickActionItem(
              icon: Icons.auto_stories_outlined,
              label: 'Courses',
              color: Colors.purple,
              onTap: () {},
            ),
            _QuickActionItem(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Wallet',
              color: Colors.green,
              onTap: () {},
            ),
            _QuickActionItem(
              icon: Icons.chat_bubble_outline,
              label: 'Chat',
              color: Colors.amber,
              onTap: () {},
            ),
            _QuickActionItem(
              icon: Icons.bar_chart_outlined,
              label: 'Reports',
              color: Colors.orange,
              onTap: () {},
            ),
            _QuickActionItem(
              icon: Icons.calendar_month_outlined,
              label: 'Schedule',
              color: Colors.indigo,
              onTap: () {},
            ),
            _QuickActionItem(
              icon: Icons.emoji_events_outlined,
              label: 'Rewards',
              color: Colors.pink,
              onTap: () {},
            ),
            _QuickActionItem(
              icon: Icons.help_outline,
              label: 'Support',
              color: Colors.grey,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4B5563),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
