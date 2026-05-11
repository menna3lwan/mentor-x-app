import 'package:flutter_test/flutter_test.dart';
import 'package:parent/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/parent_patrol_harness.dart';

void main() {
  patrolTest('Parent home page and monitor navigation', ($) async {
    await launchParentApp($);
    await goToParentRoute($, const HomePageRoute());
    await $.pumpAndSettle();

    // Verify presence of major components
    expect($('Performance Summary'), findsOneWidget);
    expect($('Quick Actions'), findsOneWidget);

    // Navigate to Attendance Monitor
    await $('Attendance').tap();
    await $.pumpAndSettle();
    expect($('Attendance Monitor'), findsOneWidget);
    await $('Back').tap();
    await $.pumpAndSettle();

    // Navigate to Academic Monitor
    await $('Academic').tap();
    await $.pumpAndSettle();
    expect($('Academic Monitor'), findsOneWidget);
    await $('Back').tap();
    await $.pumpAndSettle();

    // Navigate to Grade Monitor
    await $('Grades').tap();
    await $.pumpAndSettle();
    expect($('Grade Monitor'), findsOneWidget);
    await $('Back').tap();
    await $.pumpAndSettle();
  });
}
