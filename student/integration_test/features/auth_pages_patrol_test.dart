import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/student_patrol_harness.dart';

void main() {
  patrolTest('Student auth routes are reachable', ($) async {
    await launchStudentApp($);

    final routes = <GoRouteData>[
      const LoginPageRoute(),
      const RegistrationPageRoute(),
      const OtpPageRoute(
        phoneNumber: '01000000000',
        otpLength: 6,
        otpDurationSeconds: 60,
      ),
    ];

    for (final route in routes) {
      await goToStudentRoute($, route);
    }
  });

  patrolTest('Student login active account routes to home shell', ($) async {
    await launchStudentApp($);
    await goToStudentRoute($, const LoginPageRoute());

    await _submitStudentLogin($, phone: '01000000000');
    await $.pumpAndSettle();

    expect(currentStudentLocation(), '/');
  });

  patrolTest('Student login pending account routes to pending status', (
    $,
  ) async {
    await launchStudentApp($);
    await goToStudentRoute($, const LoginPageRoute());

    await _submitStudentLogin($, phone: '01000000001');
    await $.pumpAndSettle();

    expect(currentStudentLocation(), '/status-pending');
  });

  patrolTest('Student login blocked account routes to blocked status', (
    $,
  ) async {
    await launchStudentApp($);
    await goToStudentRoute($, const LoginPageRoute());

    await _submitStudentLogin($, phone: '01000000002');
    await $.pumpAndSettle();

    expect(currentStudentLocation(), '/status-blocked');
  });

  patrolTest('Student login rejected account routes to rejected status', (
    $,
  ) async {
    await launchStudentApp($);
    await goToStudentRoute($, const LoginPageRoute());

    await _submitStudentLogin($, phone: '01000000003');
    await $.pumpAndSettle();

    expect(currentStudentLocation(), '/status-rejected');
  });

  patrolTest('Student login OTP-required account routes to OTP page', (
    $,
  ) async {
    await launchStudentApp($);
    await goToStudentRoute($, const LoginPageRoute());

    await _submitStudentLogin($, phone: '01000000004');
    await $.pumpAndSettle();

    expect(currentStudentLocation(), '/otp');
  });
}

Future<void> _submitStudentLogin(
  PatrolIntegrationTester $, {
  required String phone,
}) async {
  await $(TextFormField).at(0).enterText(phone);
  await $(TextFormField).at(1).enterText('Test@1234');
  await $(ElevatedButton).tap();
}
