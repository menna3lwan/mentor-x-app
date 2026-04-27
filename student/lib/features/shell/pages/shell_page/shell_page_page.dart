import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
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
            child: ZoomIn(
              duration: const Duration(milliseconds: 600),
              child: const AiFabButton(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 74,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    Icons.home_outlined,
                    Icons.home_rounded,
                    t['navHome'] ?? 'Home',
                    0,
                  ),
                  _buildNavItem(
                    Icons.menu_book_outlined,
                    Icons.menu_book_rounded,
                    t['navCourses'] ?? 'Courses',
                    1,
                  ),
                  _buildNavItem(
                    Icons.quiz_outlined,
                    Icons.quiz_rounded,
                    t['navQuizzes'] ?? 'Quizzes',
                    2,
                  ),
                  _buildNavItem(
                    Icons.account_balance_wallet_outlined,
                    Icons.account_balance_wallet_rounded,
                    t['navWallet'] ?? 'Wallet',
                    3,
                  ),
                  _buildNavItem(
                    Icons.person_outline_rounded,
                    Icons.person_rounded,
                    t['navAccount'] ?? 'Account',
                    4,
                  ),
                ],
              ),
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
            AnimatedScale(
              scale: isActive ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive ? AppColors.accent : AppColors.grey,
              ),
            ),
            const Gap(4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                color: isActive ? AppColors.accent : AppColors.grey,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
