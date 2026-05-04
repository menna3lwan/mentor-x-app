import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import '../helpers/student_patrol_harness.dart';
import '../helpers/robot_helper.dart';

void main() {
  patrolTest('Comprehensive Robot Student App Navigation', ($) async {
    // 1. Launch & Login
    await launchStudentApp($);
    await $.pump(const Duration(seconds: 2));
    
    if (currentStudentLocation() == '/login') {
      await $.loginAsStudent();
    }
    await $.waitForPage('/');

    // 2. Announcements (Quick Action / Header Icon)
    await $.tapIcon(Icons.campaign_rounded);
    await $.waitForPage('/announcements');
    await $.goBack();
    await $.waitForPage('/');

    // 3. Notifications
    await $.tapIcon(Icons.notifications_rounded);
    await $.waitForPage('/notifications');
    await $.goBack();
    await $.waitForPage('/');

    // 4. Learning Tab
    await $.tapBottomNav(1);
    await $.waitForPage('/my-courses');
    // Tap a course if exists
    if ($(GestureDetector).at(0).exists) {
       await $(GestureDetector).at(0).tap();
       await $.pump(const Duration(seconds: 2));
       // Go back from course detail
       await $.goBack();
    }
    await $.waitForPage('/my-courses');

    // 5. Quizzes Tab
    await $.tapBottomNav(2);
    await $.waitForPage('/quiz-list');
    await $.tapBottomNav(0); // Back to Home

    // 6. Marketplace (Quick Action)
    // We use a broader finder to find the marketplace icon in the quick actions grid
    if ($(Icons.shopping_bag_outlined).exists) {
        await $.scrollAndTap($(Icons.shopping_bag_outlined).at(0));
        await $.waitForPage('/products');
        
        // Add first item to cart if available
        if ($(Icons.add_shopping_cart_rounded).exists) {
          await $(Icons.add_shopping_cart_rounded).at(0).tap();
          await $.pump(const Duration(seconds: 2));
        }
        
        // View cart
        await $.tapIcon(Icons.shopping_bag_outlined);
        await $.waitForPage('/cart');
        await $.goBack();
        await $.goBack();
    }
    await $.waitForPage('/');

    // 7. Wallet Tab
    await $.tapBottomNav(3);
    await $.waitForPage('/wallet');
    // View orders if button exists
    if ($('Orders').exists) {
        await $.scrollAndTap($('Orders'));
        await $.waitForPage('/wallet/orders');
        await $.goBack();
    }
    await $.waitForPage('/wallet');

    // 8. Profile Tab
    await $.tapBottomNav(4);
    await $.waitForPage('/profile');
    
    // 9. Settings
    await $.tapIcon(Icons.settings_rounded);
    await $.waitForPage('/settings');
    await $.goBack();
    await $.waitForPage('/profile');
    
    // 10. Logout
    await $.scrollAndTap($(Icons.logout_rounded));
    await $.pump(const Duration(seconds: 2));
    
    // Confirm logout dialog if it appears
    if ($('Log Out').exists) {
      // Find the "Log Out" button in the dialog (usually the second button)
      await $(ElevatedButton).at(1).tap();
      await $.pump(const Duration(seconds: 2));
    }
    await $.waitForPage('/login');
  });
}
