import 'package:parent/core/core.dart';
import 'package:patrol/patrol.dart';

import '../helpers/parent_patrol_harness.dart';

void main() {
  patrolTest('Parent home page smoke', ($) async {
    await launchParentApp($);
    await goToParentRoute($, const HomePageRoute());
  });
}
