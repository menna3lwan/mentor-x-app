import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_student/app/app.dart';
import 'package:patrol/patrol.dart';

Future<void> launchStudentApp(PatrolIntegrationTester $) async {
  final requirements = await StudentRequirements.initialize();
  await $.pumpWidget(StudentApp(requirements: requirements));
}

Future<void> goToStudentRoute(
  PatrolIntegrationTester $,
  GoRouteData route,
) async {
  final context = rootNavigatorKey.currentContext;
  expect(context, isNotNull);
  route.go(context!);
  await $.pump(const Duration(seconds: 2));
}

String currentStudentLocation() {
  final context = rootNavigatorKey.currentContext;
  expect(context, isNotNull);
  return GoRouter.of(context!).routeInformationProvider.value.uri.path;
}
