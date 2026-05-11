import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../widgets/ai_fab_button.dart';
import '../../widgets/app_drawer.dart';

final class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      drawer: AppDrawer(onTabSelected: (i) => navigationShell.goBranch(i)),
      body: Stack(
        children: [
          navigationShell,
          PositionedDirectional(
            bottom: 100,
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
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border(
              top: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context,
                    Icons.home_outlined,
                    Icons.home_rounded,
                    t['navHome'] ?? 'Home',
                    0,
                  ),
                  _buildNavItem(
                    context,
                    Icons.menu_book_outlined,
                    Icons.menu_book_rounded,
                    t['navCourses'] ?? 'Courses',
                    1,
                  ),
                  _buildNavItem(
                    context,
                    Icons.quiz_outlined,
                    Icons.quiz_rounded,
                    t['navQuizzes'] ?? 'Quizzes',
                    2,
                  ),
                  _buildNavItem(
                    context,
                    Icons.account_balance_wallet_outlined,
                    Icons.account_balance_wallet_rounded,
                    t['navWallet'] ?? 'Wallet',
                    3,
                  ),
                  _buildNavItem(
                    context,
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
    BuildContext context,
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final isActive = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => navigationShell.goBranch(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive
                    ? context.brandPrimaryColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive
                    ? context.brandPrimaryColor
                    : context.textTertiaryColor,
              ),
            ),
            const Gap(4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
                color: isActive
                    ? context.brandPrimaryColor
                    : context.textTertiaryColor,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
