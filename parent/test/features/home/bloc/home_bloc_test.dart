import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/home/bloc/home_bloc.dart';

class _MockChildrenRepository extends Mock
    implements ParentChildrenRepository {}

class _MockHomeRepository extends Mock implements ParentHomeRepository {}

class _MockCacheRepository extends Mock implements CacheRepository {}

void main() {
  late _MockChildrenRepository childrenRepository;
  late _MockHomeRepository homeRepository;
  late _MockCacheRepository cacheRepository;

  const childAId = 'child-a';
  const childBId = 'child-b';

  const childA = ParentChildEntity(
    id: childAId,
    name: 'Ahmed Kamal',
    gradeName: 'Primary 5',
  );
  const childB = ParentChildEntity(
    id: childBId,
    name: 'Layla Hassan',
    gradeName: 'Primary 3',
  );

  final summary = ParentHomeSummaryEntity(
    overview: const ParentHomeOverviewEntity(
      unpaidInvoicesCount: 0,
      avgAttendanceRate: 0.95,
      avgGrade: 88.0,
      totalPoints: 100,
    ),
    upcomingSessions: const [],
    recentGrades: const [],
    latestAnnouncement: null,
    childrenSummaries: const [],
  );

  final activity = <ParentRecentActivityEntity>[];
  final announcements = <AnnouncementEntity>[];

  HomeBloc buildBloc() => HomeBloc(
        childrenRepository: childrenRepository,
        homeRepository: homeRepository,
        cacheRepository: cacheRepository,
      );

  void stubHomeRepoSuccess(String childId) {
    when(() => homeRepository.getSummary(childId))
        .thenAnswer((_) async => summary);
    when(() => homeRepository.getRecentActivity(childId))
        .thenAnswer((_) async => activity);
    when(() => homeRepository.getAnnouncements(childId))
        .thenAnswer((_) async => announcements);
  }

  setUp(() {
    childrenRepository = _MockChildrenRepository();
    homeRepository = _MockHomeRepository();
    cacheRepository = _MockCacheRepository();
    when(() => cacheRepository.put(any(), any())).thenAnswer((_) async {});
    when(() => cacheRepository.get(any())).thenAnswer((_) async => null);
  });

  group('HomeBloc.HomeStarted', () {
    test('initial state is HomeState.initial()', () {
      final bloc = buildBloc();
      expect(bloc.state, equals(HomeState.initial()));
      bloc.close();
    });

    blocTest<HomeBloc, HomeState>(
      'loads children, picks first child, and loads dashboard sections',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => [childA, childB]);
        stubHomeRepoSuccess(childAId);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const HomeStarted()),
      verify: (bloc) {
        expect(bloc.state.children, [childA, childB]);
        expect(bloc.state.selectedChild?.id, childAId);
        expect(bloc.state.summarySection.isLoaded, isTrue);
        expect(bloc.state.activitySection.isLoaded, isTrue);
        expect(bloc.state.announcementsSection.isLoaded, isTrue);
        expect(bloc.state.lastUpdatedAt, isNotNull);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'empty children list clears selectedChild and stops there',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => <ParentChildEntity>[]);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const HomeStarted()),
      verify: (bloc) {
        expect(bloc.state.children, isEmpty);
        expect(bloc.state.selectedChild, isNull);
        expect(bloc.state.summarySection.isInitial, isTrue);
        verifyNever(() => homeRepository.getSummary(any()));
      },
    );

    blocTest<HomeBloc, HomeState>(
      'restores previously cached selectedChild when valid',
      setUp: () {
        when(() => cacheRepository.get('selected_child_id'))
            .thenAnswer((_) async => childBId);
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => [childA, childB]);
        stubHomeRepoSuccess(childBId);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const HomeStarted()),
      verify: (bloc) {
        expect(bloc.state.selectedChild?.id, childBId);
        verify(() => homeRepository.getSummary(childBId)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'children fetch failure leaves children section in failure',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenThrow(Exception('network down'));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const HomeStarted()),
      verify: (bloc) {
        expect(bloc.state.childrenSection.isFailure, isTrue);
        expect(bloc.state.selectedChild, isNull);
      },
    );
  });

  group('HomeBloc.HomeChildSwitched', () {
    blocTest<HomeBloc, HomeState>(
      'switches the active child and reloads dashboard',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => [childA, childB]);
        stubHomeRepoSuccess(childAId);
        stubHomeRepoSuccess(childBId);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HomeStarted());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(const HomeChildSwitched(childB));
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.selectedChild?.id, childBId);
        verify(() => homeRepository.getSummary(childBId)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'noop if the same child is tapped twice',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => [childA, childB]);
        stubHomeRepoSuccess(childAId);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HomeStarted());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(const HomeChildSwitched(childA));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        // Summary should only be fetched once (during start), not again
        // for the redundant tap.
        verify(() => homeRepository.getSummary(childAId)).called(1);
      },
    );
  });

  group('HomeBloc.HomeRetrySectionRequested', () {
    blocTest<HomeBloc, HomeState>(
      'retries the summary section only',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => [childA]);
        when(() => homeRepository.getSummary(childAId))
            .thenAnswer((_) async => summary);
        when(() => homeRepository.getRecentActivity(childAId))
            .thenAnswer((_) async => activity);
        when(() => homeRepository.getAnnouncements(childAId))
            .thenAnswer((_) async => announcements);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HomeStarted());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(
          const HomeRetrySectionRequested(HomeSection.summary),
        );
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        verify(() => homeRepository.getSummary(childAId)).called(2);
        // Activity should only be loaded once (initial), not again.
        verify(() => homeRepository.getRecentActivity(childAId)).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'retry on summary is a noop when no child is selected',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => <ParentChildEntity>[]);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HomeStarted());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(const HomeRetrySectionRequested(HomeSection.summary));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verifyNever(() => homeRepository.getSummary(any()));
      },
    );
  });

  group('HomeBloc.HomeRefreshRequested', () {
    blocTest<HomeBloc, HomeState>(
      'reloads children and dashboard, preserves selected child',
      setUp: () {
        when(() => childrenRepository.getChildren())
            .thenAnswer((_) async => [childA, childB]);
        stubHomeRepoSuccess(childAId);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const HomeStarted());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(const HomeRefreshRequested());
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.selectedChild?.id, childAId);
        expect(bloc.state.isRefreshing, isFalse);
        verify(() => childrenRepository.getChildren()).called(2);
      },
    );
  });
}
