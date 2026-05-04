import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import '../helpers/parent_patrol_harness.dart';

void main() {
  patrolTest('Parent app smoke test', ($) async {
    await launchParentApp($);
    await $.pumpAndSettle();
    
    // Basic verification that we are on some page (likely /login or /dashboard)
    expect(currentParentLocation(), isNotEmpty);
  });
}
