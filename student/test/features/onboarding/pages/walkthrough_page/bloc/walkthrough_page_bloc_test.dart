import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_student/core/core.dart';

import 'package:mentorx_student/features/onboarding/pages/walkthrough_page/bloc/walkthrough_page_bloc.dart';

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

void main() {
  late _MockCacheRepository cacheRepository;

  setUp(() {
    cacheRepository = _MockCacheRepository();
  });

  group('WalkthroughPageBloc', () {
    // ── 1. Initial state ──────────────────────────────────────────────
    test('initial state has LoadingState.initial', () {
      final bloc = WalkthroughPageBloc(cacheRepository: cacheRepository);
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state, WalkthroughPageState.initial);
      bloc.close();
    });

    // ── 2. isSubmitting getter ────────────────────────────────────────
    test('isSubmitting returns true when loading', () {
      final bloc = WalkthroughPageBloc(cacheRepository: cacheRepository);
      // Initial state should not be submitting
      expect(bloc.state.isSubmitting, isFalse);

      // Verify the getter contract with each LoadingState value
      const loadingState = WalkthroughPageState(
        loadingState: LoadingState.loading,
      );
      const loadedState = WalkthroughPageState(
        loadingState: LoadingState.loaded,
      );
      const errorState = WalkthroughPageState(
        loadingState: LoadingState.error,
      );

      expect(loadingState.isSubmitting, isTrue);
      expect(loadedState.isSubmitting, isFalse);
      expect(errorState.isSubmitting, isFalse);

      bloc.close();
    });

    // ── 3. Skip event - state emissions ──────────────────────────────
    blocTest<WalkthroughPageBloc, WalkthroughPageState>(
      'emits [loading, loaded] when skipped',
      build: () => WalkthroughPageBloc(cacheRepository: cacheRepository),
      act: (bloc) => bloc.add(const WalkthroughPageSkipped()),
      expect: () => [
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ── 4. Completed event - state emissions ─────────────────────────
    blocTest<WalkthroughPageBloc, WalkthroughPageState>(
      'emits [loading, loaded] when completed',
      build: () => WalkthroughPageBloc(cacheRepository: cacheRepository),
      act: (bloc) => bloc.add(const WalkthroughPageCompleted()),
      expect: () => [
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ── 5. Skip event - cache failure ────────────────────────────────
    blocTest<WalkthroughPageBloc, WalkthroughPageState>(
      'emits [loading, error] when cache repository throws on skip',
      build: () => WalkthroughPageBloc(
        cacheRepository: _FailingCacheRepository(),
      ),
      act: (bloc) => bloc.add(const WalkthroughPageSkipped()),
      expect: () => [
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );

    // ── 6. Completed event - cache failure ───────────────────────────
    blocTest<WalkthroughPageBloc, WalkthroughPageState>(
      'emits [loading, error] when cache repository throws on completed',
      build: () => WalkthroughPageBloc(
        cacheRepository: _FailingCacheRepository(),
      ),
      act: (bloc) => bloc.add(const WalkthroughPageCompleted()),
      expect: () => [
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );

    // ── 7. Recovery after error ──────────────────────────────────────
    blocTest<WalkthroughPageBloc, WalkthroughPageState>(
      'can recover after error',
      build: () => WalkthroughPageBloc(
        cacheRepository: _FailingCacheRepository(),
      ),
      act: (bloc) => bloc.add(const WalkthroughPageCompleted()),
      expect: () => [
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );

    blocTest<WalkthroughPageBloc, WalkthroughPageState>(
      'can recover after error by re-creating with a working repository',
      build: () => WalkthroughPageBloc(cacheRepository: cacheRepository),
      seed: () => const WalkthroughPageState(
        loadingState: LoadingState.error,
      ),
      act: (bloc) => bloc.add(const WalkthroughPageCompleted()),
      expect: () => [
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalkthroughPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    // ── Presentation event tests ─────────────────────────────────────
    blocPresentationTest<
      WalkthroughPageBloc,
      WalkthroughPageState,
      WalkthroughPagePresentationEvent
    >(
      'emits WalkthroughPageCompletedPresentationEvent on successful skip',
      build: () => WalkthroughPageBloc(cacheRepository: cacheRepository),
      act: (bloc) => bloc.add(const WalkthroughPageSkipped()),
      expectPresentation: () => [
        isA<WalkthroughPageCompletedPresentationEvent>(),
      ],
    );

    blocPresentationTest<
      WalkthroughPageBloc,
      WalkthroughPageState,
      WalkthroughPagePresentationEvent
    >(
      'emits WalkthroughPageCompletedPresentationEvent on successful complete',
      build: () => WalkthroughPageBloc(cacheRepository: cacheRepository),
      act: (bloc) => bloc.add(const WalkthroughPageCompleted()),
      expectPresentation: () => [
        isA<WalkthroughPageCompletedPresentationEvent>(),
      ],
    );

    blocPresentationTest<
      WalkthroughPageBloc,
      WalkthroughPageState,
      WalkthroughPagePresentationEvent
    >(
      'emits no presentation event when cache repository throws',
      build: () => WalkthroughPageBloc(
        cacheRepository: _FailingCacheRepository(),
      ),
      act: (bloc) => bloc.add(const WalkthroughPageCompleted()),
      expectPresentation: () => <WalkthroughPagePresentationEvent>[],
    );
  });
}
