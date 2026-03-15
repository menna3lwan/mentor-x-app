import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../widgets/ai_fab_button.dart';
import '../../widgets/app_drawer.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: AppDrawer(onTabSelected: (i) => navigationShell.goBranch(i)),
      body: Stack(
        children: [
          navigationShell,
          PositionedDirectional(
            bottom: 90,
            start: 20,
            child: const AiFabButton(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  Icons.home_outlined,
                  Icons.home,
                  t['navHome']!,
                  0,
                ),
                _buildNavItem(
                  Icons.menu_book_outlined,
                  Icons.menu_book,
                  t['navCourses']!,
                  1,
                ),
                _buildNavItem(
                  Icons.quiz_outlined,
                  Icons.quiz,
                  t['navQuizzes']!,
                  2,
                ),
                _buildNavItem(
                  Icons.account_balance_wallet_outlined,
                  Icons.account_balance_wallet,
                  t['navWallet']!,
                  3,
                ),
                _buildNavItem(
                  Icons.person_outline,
                  Icons.person,
                  t['navAccount']!,
                  4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final isActive = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => navigationShell.goBranch(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 22,
              color: isActive ? AppColors.accent : AppColors.grey,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.accent : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
