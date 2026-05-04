import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import '../helpers/student_patrol_harness.dart';
import '../helpers/robot_helper.dart';

void main() {
  patrolTest('Student App Stress Test - Robot Overload', ($) async {
    await launchStudentApp($);
    await $.pump(const Duration(seconds: 2));
    
    if (currentStudentLocation() == '/login') {
      await $.loginAsStudent();
    }
    await $.waitForPage('/');

    // 1. Rapid Tab Switching
    for (int i = 0; i < 3; i++) {
      await $.navigateThroughTabs();
    }

    // 2. Rapid Pull-to-Refresh on Dashboard
    for (int i = 0; i < 5; i++) {
      // Use the pullToRefresh from RobotHelper (we'll add it)
      // or manual drag
      await $.tester.drag($(Scaffold), const Offset(0, 500));
      await $.pump(const Duration(seconds: 2));
    }

    // 3. Page Opening/Closing Stress
    // Go to Learning, open course, go back, repeat
    await $.tapBottomNav(1);
    await $.waitForPage('/my-courses');
    for (int i = 0; i < 3; i++) {
      if ($(GestureDetector).at(0).exists) {
        await $(GestureDetector).at(0).tap();
        await $.pump(const Duration(seconds: 2));
        await $.goBack();
        await $.pump(const Duration(seconds: 2));
      }
    }

    // 4. Action Clicking Stress
    // Click random icons in the header
    await $.tapBottomNav(0);
    await $.waitForPage('/');
    for (int i = 0; i < 5; i++) {
      await $.tapIcon(Icons.campaign_rounded);
      await $.pump(const Duration(seconds: 2));
      await $.goBack();
      await $.pump(const Duration(seconds: 2));
      await $.tapIcon(Icons.notifications_rounded);
      await $.pump(const Duration(seconds: 2));
      await $.goBack();
      await $.pump(const Duration(seconds: 2));
    }

    // Back to home
    await $.waitForPage('/');
  });
}
