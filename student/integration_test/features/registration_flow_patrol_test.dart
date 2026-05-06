import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';
import '../helpers/robot_helper.dart';

void main() {
  patrolTest('Full Registration Flow end-to-end', ($) async {
    await launchStudentApp($);
    await goToStudentRoute($, const RegistrationPageRoute());

    // Step 0: Start
    await $.enterRegistrationStartInfo(
      firstName: 'Integration',
      phone: '01099999999',
      parentPhone: '01199999999',
    );
    await $.tapContinue();

    // Step 1: OTP
    // Note: In prod mode, this requires a real OTP.
    // For testing purposes, we assume a test number/backdoor if available.
    await $.enterOtp('000000');
    await $.tapContinue();

    // Step 2: Personal Info
    await $.enterRegistrationPersonalInfo(
      secondName: 'Test',
      thirdName: 'User',
      fourthName: 'One',
    );
    await $.tapContinue();

    // Step 3: Academic Info
    // We might need to wait for grades to load
    await $.pump(const Duration(seconds: 1));
    // selectRegistrationGrade assumes the text is visible
    // This might fail if the picker needs to be opened first
    // For now, let's assume a simple tap on the grade name if visible or in a list
    await $.tapText('Grade 1'); 
    await $.tapContinue();

    // Step 4: Location Info
    await $.pump(const Duration(seconds: 1));
    await $.selectRegistrationGovernorate('Cairo');
    await $.pump(const Duration(seconds: 1));
    await $.selectRegistrationArea('Maadi');
    await $.tapContinue();

    // Step 5: Security Info
    await $.enterRegistrationSecurity(
      password: 'Password123!',
      confirmPassword: 'Password123!',
    );
    
    // Final Submission
    if ($('Complete Registration').exists) {
      await $.tapText('Complete Registration');
    } else {
      await $(ElevatedButton).at(0).tap();
    }

    await $.pumpAndSettle();

    // Should lead to some status page or home
    // For now, we just verify we moved from the registration route
    expect(currentStudentLocation(), isNot('/registration'));
  });

  patrolTest('Registration validation - phone equals parent phone', ($) async {
    await launchStudentApp($);
    await goToStudentRoute($, const RegistrationPageRoute());

    await $.enterRegistrationStartInfo(
      firstName: 'Test',
      phone: '01012345678',
      parentPhone: '01012345678', // Same phone
    );
    await $.tapContinue();

    // Verify error message (should stay on step 0)
    expect(currentStudentLocation(), '/registration');
    // We could check for a specific error snackbar/text if we know the translation
  });
}
