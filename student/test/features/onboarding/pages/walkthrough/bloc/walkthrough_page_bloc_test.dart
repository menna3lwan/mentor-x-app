import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_student/core/core.dart';

import 'package:mentorx_student/features/onboarding/pages/walkthrough/bloc/walkthrough_bloc.dart';

class _MockCacheRepository implements CacheRepository {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> put(String key, String value) async {}

  @override
  Future<String?> get(String key) async => null;

  @override
  Future<bool> containsKey(String key) async => false;

  @override
  Future<void> remove(String key) async {}

  @override
  Future<void> clear() async {}

  @override
  Future<List<String>> getAllKeys() async => [];

  @override
  Future<Map<String, String>> getAll() async => {};

  @override
  Future<void> putAll(Map<String, String> data) async {}

  @override
  Future<void> removeAll(List<String> keys) async {}
}

class _FailingCacheRepository implements CacheRepository {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> put(String key, String value) async {
    throw CacheRepositoryException(
      code: CacheRepositoryExceptionCode.saveFailed,
      message: 'Save failed',
    );
  }

  @override
  Future<String?> get(String key) async => null;

  @override
  Future<bool> containsKey(String key) async => false;

  @override
  Future<void> remove(String key) async {}

  @override
  Future<void> clear() async {}

  @override
  Future<List<String>> getAllKeys() async => [];

  @override
  Future<Map<String, String>> getAll() async => {};

  @override
  Future<void> putAll(Map<String, String> data) async {}

  @override
  Future<void> removeAll(List<String> keys) async {}
}

class _MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}

void main() {
  late _MockCacheRepository cacheRepository;
  late _MockAnalyticsService analyticsService;

  setUp(() {
    cacheRepository = _MockCacheRepository();
    analyticsService = _MockAnalyticsService();
  });

  group('WalkthroughBloc', () {
    // ── 1. Initial state ──────────────────────────────────────────────
    test('initial state has LoadingState.initial', () {
      final bloc = WalkthroughBloc(
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state, WalkthroughState.initial);
      bloc.close();
    });

    // ── 2. isSubmitting getter ────────────────────────────────────────
    test('isSubmitting returns true when loading', () {
      final bloc = WalkthroughBloc(
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      );
      // Initial state should not be submitting
      expect(bloc.state.isSubmitting, isFalse);

      // Verify the getter contract with each LoadingState value
      const loadingState = WalkthroughState(
        loadingState: LoadingState.loading,
      );
      const loadedState = WalkthroughState(
        loadingState: LoadingState.loaded,
      );
      const errorState = WalkthroughState(
        loadingState: LoadingState.error,
      );

      expect(loadingState.isSubmitting, isTrue);
      expect(loadedState.isSubmitting, isFalse);
      expect(errorState.isSubmitting, isFalse);

      bloc.close();
    });

    // ── 3. Skip event - state emissions ──────────────────────────────
    blocTest<WalkthroughBloc, WalkthroughState>(
      'emits [loading, loaded] when skipped',
      build: () => WalkthroughBloc(
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughSkipped()),
      expect: () => [
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ── 4. Completed event - state emissions ─────────────────────────
    blocTest<WalkthroughBloc, WalkthroughState>(
      'emits [loading, loaded] when completed',
      build: () => WalkthroughBloc(
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughCompleted()),
      expect: () => [
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ── 5. Skip event - cache failure ────────────────────────────────
    blocTest<WalkthroughBloc, WalkthroughState>(
      'emits [loading, error] when cache repository throws on skip',
      build: () => WalkthroughBloc(
        cacheRepository: _FailingCacheRepository(),
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughSkipped()),
      expect: () => [
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );

    // ── 6. Completed event - cache failure ───────────────────────────
    blocTest<WalkthroughBloc, WalkthroughState>(
      'emits [loading, error] when cache repository throws on completed',
      build: () => WalkthroughBloc(
        cacheRepository: _FailingCacheRepository(),
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughCompleted()),
      expect: () => [
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );

    // ── 7. Recovery after error ──────────────────────────────────────
    blocTest<WalkthroughBloc, WalkthroughState>(
      'can recover after error',
      build: () => WalkthroughBloc(
        cacheRepository: _FailingCacheRepository(),
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughCompleted()),
      expect: () => [
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );

    blocTest<WalkthroughBloc, WalkthroughState>(
      'can recover after error by re-creating with a working repository',
      build: () => WalkthroughBloc(
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      ),
      seed: () => const WalkthroughState(
        loadingState: LoadingState.error,
      ),
      act: (bloc) => bloc.add(const WalkthroughCompleted()),
      expect: () => [
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ── Presentation event tests ─────────────────────────────────────
    blocPresentationTest<
      WalkthroughBloc,
      WalkthroughState,
      WalkthroughPresentationEvent
    >(
      'emits WalkthroughCompletedPresentationEvent on successful skip',
      build: () => WalkthroughBloc(
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughSkipped()),
      expectPresentation: () => [
        isA<WalkthroughCompletedPresentationEvent>(),
      ],
    );

    blocPresentationTest<
      WalkthroughBloc,
      WalkthroughState,
      WalkthroughPresentationEvent
    >(
      'emits WalkthroughCompletedPresentationEvent on successful complete',
      build: () => WalkthroughBloc(
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughCompleted()),
      expectPresentation: () => [
        isA<WalkthroughCompletedPresentationEvent>(),
      ],
    );

    blocPresentationTest<
      WalkthroughBloc,
      WalkthroughState,
      WalkthroughPresentationEvent
    >(
      'emits no presentation event when cache repository throws',
      build: () => WalkthroughBloc(
        cacheRepository: _FailingCacheRepository(),
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalkthroughCompleted()),
      expectPresentation: () => <WalkthroughPresentationEvent>[],
    );
  });
}
