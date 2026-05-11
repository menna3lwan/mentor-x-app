import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol/src/platform/contracts/contracts.dart';
import 'package:test_api/src/backend/invoker.dart';

import 'features/smoke_test.dart' as smoke_test;
import 'features/auth_pages_patrol_test.dart' as auth_pages;
import 'features/home_pages_patrol_test.dart' as home_pages;

Future<void> main() async {
  final platformAutomator = PlatformAutomator(
    config: PlatformAutomatorConfig.defaultConfig(),
  );
  await platformAutomator.initialize();
  final binding = PatrolBinding.ensureInitialized(platformAutomator);
  final testExplorationCompleter = Completer<DartGroupEntry>();

  test('patrol_test_explorer', () {
    final topLevelGroup = Invoker.current!.liveTest.groups.first;
    // ignore: invalid_use_of_internal_member
    final dartTestGroup = createDartTestGroup(
      topLevelGroup,
      tags: null,
      excludeTags: null,
    );
    testExplorationCompleter.complete(dartTestGroup);
  });

  group('features.smoke_test', smoke_test.main);
  group('features.auth_pages', auth_pages.main);
  group('features.home_pages', home_pages.main);

  final dartTestGroup = await testExplorationCompleter.future;
  final appService = PatrolAppService(topLevelDartTestGroup: dartTestGroup);
  binding.patrolAppService = appService;
  await runAppService(appService);
  await platformAutomator.markPatrolAppServiceReady();
  await appService.testExecutionCompleted;
}
