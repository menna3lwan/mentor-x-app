import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:mentorx_student/app/student_app.dart';
import 'student_patrol_harness.dart';

extension RobotHelper on PatrolIntegrationTester {
  Future<void> loginAsStudent({
    String phone = '01000000000',
    String password = '123123',
  }) async {
    await this(TextFormField).at(0).waitUntilVisible();
    await this(TextFormField).at(0).enterText(phone);
    await this(TextFormField).at(1).enterText(password);
    await this(ElevatedButton).tap();
    await pump(const Duration(seconds: 2));
  }

  Future<void> enterRegistrationStartInfo({
    required String firstName,
    required String phone,
    required String parentPhone,
  }) async {
    await this(TextFormField).at(0).enterText(firstName);
    await this(TextFormField).at(1).enterText(phone);
    await this(TextFormField).at(2).enterText(parentPhone);
  }

  Future<void> enterOtp(String otp) async {
    // Pinput usually uses one editable text field internally or multiple
    // Patrol's enterText on Pinput usually works if it finds the internal TextField
    await this(TextFormField).enterText(otp);
    await pump(const Duration(seconds: 1));
  }

  Future<void> enterRegistrationPersonalInfo({
    required String secondName,
    required String thirdName,
    required String fourthName,
  }) async {
    await this(TextFormField).at(0).enterText(secondName);
    await this(TextFormField).at(1).enterText(thirdName);
    await this(TextFormField).at(2).enterText(fourthName);
  }

  Future<void> selectRegistrationGrade(String gradeName) async {
    // Assuming MentorXGradePicker or similar shows text
    await tapText(gradeName);
  }

  Future<void> selectRegistrationGovernorate(String govName) async {
    await tapText(govName);
  }

  Future<void> selectRegistrationArea(String areaName) async {
    await tapText(areaName);
  }

  Future<void> enterRegistrationSecurity({
    required String password,
    required String confirmPassword,
  }) async {
    await this(TextFormField).at(0).enterText(password);
    await this(TextFormField).at(1).enterText(confirmPassword);
  }

  Future<void> tapContinue() async {
    // The "Continue" button is a MentorXButton which is likely an ElevatedButton or similar
    // We can also find it by text if we know the locale, but for tests we might use types or keys
    if (this('Continue').exists) {
      await tapText('Continue');
    } else if (this('Verify & Continue').exists) {
      await tapText('Verify & Continue');
    } else {
      await this(ElevatedButton).at(0).tap();
    }
    await pump(const Duration(seconds: 2));
  }

  Future<void> tapBottomNav(int index) async {
    // In our custom shell, it's a Row of GestureDetector widgets inside a Container at the bottom
    await this(GestureDetector).at(index).tap();
    await pump(const Duration(seconds: 2));
  }

  Future<void> tapIcon(IconData icon) async {
    await this(icon).tap();
    await pump(const Duration(seconds: 2));
  }

  Future<void> tapText(String text) async {
    await this(text).tap();
    await pump(const Duration(seconds: 2));
  }

  Future<void> goBack() async {
    if (rootNavigatorKey.currentContext != null) {
      final canPop = Navigator.of(rootNavigatorKey.currentContext!).canPop();
      if (canPop) {
        // Try BackButton first
        if (this(BackButton).exists) {
          await this(BackButton).tap();
        } else if (this(IconButton).at(0).exists) {
          await this(IconButton).at(0).tap();
        } else {
          // Fallback to Navigator.pop
          Navigator.of(rootNavigatorKey.currentContext!).pop();
        }
      }
    } else {
      await this(BackButton).tap();
    }
    await pump(const Duration(seconds: 2));
  }

  Future<void> scrollAndTap(PatrolFinder finder) async {
    await scrollUntilVisible(finder: finder);
    await finder.tap();
    await pump(const Duration(seconds: 2));
  }

  Future<void> waitForPage(String path) async {
    int retry = 0;
    while (currentStudentLocation() != path && retry < 30) {
      await pump(const Duration(milliseconds: 500));
      retry++;
    }
    expect(currentStudentLocation(), path);
  }

  Future<void> navigateThroughTabs() async {
    for (int i = 0; i < 5; i++) {
      await tapBottomNav(i);
      await pump(const Duration(seconds: 2));
    }
    await tapBottomNav(0);
  }

  /// Taps every button visible on the current screen.
  /// This is useful for "robot" behavior discovery.
  Future<void> tapAllVisibleButtons() async {
    // We use tester.widgetList to get the count of matching widgets
    final elevatedButtons = this(ElevatedButton);
    final count = tester.widgetList(elevatedButtons).length;

    for (int i = 0; i < count; i++) {
      await elevatedButtons.at(i).tap();
      await pump(const Duration(seconds: 2));
      await goBack();
    }

    final iconButtons = this(IconButton);
    final iconCount = tester.widgetList(iconButtons).length;
    for (int i = 0; i < iconCount; i++) {
      await iconButtons.at(i).tap();
      await pump(const Duration(seconds: 2));
      await goBack();
    }
  }
}
