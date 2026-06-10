import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:parent/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/parent_patrol_harness.dart';

void main() {
  patrolTest('Parent auth routes are reachable', ($) async {
    await launchParentApp($);

    final routes = <GoRouteData>[
      const LoginPageRoute(),
      const ForgetPasswordPageRoute(),
      const OtpPageRoute(phoneNumber: '01000000000'),
      const ParentRegistrationPageRoute(),
    ];

    for (final route in routes) {
      await goToParentRoute($, route);
    }
  });

  patrolTest('Parent login success routes to home', ($) async {
    await launchParentApp($);
    await goToParentRoute($, const LoginPageRoute());

    await $(TextFormField).at(0).enterText('01000000000');
    await $(TextFormField).at(1).enterText('Test@1234');
    await $('Log In').tap();
    await $.pumpAndSettle();

    expect(currentParentLocation(), '/home');
  });

  patrolTest('Parent login with OTP-required account routes to OTP', ($) async {
    await launchParentApp($);
    await goToParentRoute($, const LoginPageRoute());

    await $(TextFormField).at(0).enterText('01011111111');
    await $(TextFormField).at(1).enterText('Test@1234');
    await $('Log In').tap();
    await $.pumpAndSettle();

    expect(currentParentLocation(), '/otp');
  });

  patrolTest('Parent OTP success continues to the next screen', ($) async {
    await launchParentApp($);
    await goToParentRoute($, const OtpPageRoute(phoneNumber: '01011111111'));

    await $(TextFormField).enterText('123456');
    await $('تحقق وتابع').tap();
    await $.pumpAndSettle();

    expect(currentParentLocation(), isNot('/otp'));
  });

  patrolTest('Parent forgot-password opens reset dialog after sending code', (
    $,
  ) async {
    await launchParentApp($);
    await goToParentRoute($, const ForgetPasswordPageRoute());

    await $(TextFormField).enterText('01000000000');
    await $('Send Code').tap();
    await $.pumpAndSettle();

    expect($('Reset Password'), findsOneWidget);
    await $('Cancel').tap();
    await $.pumpAndSettle();
  });

  patrolTest('Parent registration submits and routes to OTP', ($) async {
    await launchParentApp($);
    await goToParentRoute($, const ParentRegistrationPageRoute());

    await $(TextFormField).at(0).enterText('01012345678');
    await $('Find Student').tap();
    await $.pumpAndSettle();

    await $('Confirm Child').tap();
    await $.pumpAndSettle();

    await $('Continue').tap();
    await $.pumpAndSettle();

    await $(TextFormField).at(0).enterText('Ali');
    await $(TextFormField).at(1).enterText('Hassan');
    await $(TextFormField).at(2).enterText('01022222222');
    await $(TextFormField).at(3).enterText('ali.hassan@example.com');
    await $('Relationship to Child').tap();
    await $('Father').tap();
    await $('Continue').tap();
    await $.pumpAndSettle();

    await $(TextFormField).at(0).enterText('Parent@123');
    await $(TextFormField).at(1).enterText('Parent@123');
    await $('Create Account').tap();
    await $.pumpAndSettle();

    expect(currentParentLocation(), '/otp');
  });
}
