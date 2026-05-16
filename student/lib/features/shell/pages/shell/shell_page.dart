import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../../widgets/ai_fab_button.dart';
import '../../widgets/app_drawer.dart';

final class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final t = context.t.shell;

    return Scaffold(
      extendBody: true,
      backgroundColor: context.backgroundPrimaryColor,
      drawer: AppDrawer(onTabSelected: (i) => navigationShell.goBranch(i)),
      body: Stack(
        children: [
          navigationShell,
          PositionedDirectional(
            bottom: 110,
            start: 24,
            child: ZoomIn(
              duration: const Duration(milliseconds: 600),
              child: const AiFabButton(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: context.backgroundSecondaryColor.withValues(
                      alpha: 0.85,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        context,
                        Icons.home_outlined,
                        Icons.home_rounded,
                        t.navHome,
                        0,
                      ),
                      _buildNavItem(
                        context,
                        Icons.menu_book_outlined,
                        Icons.menu_book_rounded,
                        t.navCourses,
                        1,
                      ),
                      _buildNavItem(
                        context,
                        Icons.quiz_outlined,
                        Icons.quiz_rounded,
                        t.navQuizzes,
                        2,
                      ),
                      _buildNavItem(
                        context,
                        Icons.account_balance_wallet_outlined,
                        Icons.account_balance_wallet_rounded,
                        t.navWallet,
                        3,
                      ),
                      _buildNavItem(
                        context,
                        Icons.person_outline_rounded,
                        Icons.person_rounded,
                        t.navAccount,
                        4,
                      ),
                    ],
                  ),
                ),
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
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isActive
                    ? context.brandPrimaryColor.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive
                    ? context.brandPrimaryColor
                    : context.textTertiaryColor,
              ),
            ),
            const Gap(2),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isActive ? 1.0 : 0.6,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w900 : FontWeight.w700,
                  color: isActive
                      ? context.brandPrimaryColor
                      : context.textTertiaryColor,
                  letterSpacing: 0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
