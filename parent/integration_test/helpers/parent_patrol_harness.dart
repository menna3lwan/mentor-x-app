import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:parent/app/parent_app.dart';
import 'package:parent/app/parent_requirements.dart';
import 'package:parent/core/core.dart';
import 'package:patrol/patrol.dart';

Future<void> launchParentApp(PatrolIntegrationTester $) async {
  final requirements = await ParentRequirements.initialize();
  await $.pumpWidgetAndSettle(ParentApp(requirements: requirements));
}

Future<void> goToParentRoute(
  PatrolIntegrationTester $,
  GoRouteData route,
) async {
  final context = rootNavigatorKey.currentContext;
  expect(context, isNotNull);
  route.go(context!);
  await $.pumpAndSettle();
}

String currentParentLocation() {
  final context = rootNavigatorKey.currentContext;
  expect(context, isNotNull);
  return GoRouter.of(context!).routeInformationProvider.value.uri.path;
}
