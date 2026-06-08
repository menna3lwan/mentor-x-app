import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/assessments/bloc/assessments_bloc.dart';

class _MockGradeRepository extends Mock implements ParentGradeRepository {}

void main() {
  late _MockGradeRepository repo;
  const childId = 'child-1';

  const summary = ParentGradeSummaryEntity(overallAverage: 85.0);
  const trend = ParentGradeTrendEntity(months: []);

  AssessmentsBloc buildBloc() => AssessmentsBloc(repository: repo);

  void stubAllSuccess() {
    when(
      () => repo.getAssessments(childId),
    ).thenAnswer((_) async => const <QuizAttemptEntity>[]);
    when(() => repo.getGradeSummary(childId)).thenAnswer((_) async => summary);
    when(() => repo.getGradeTrend(childId)).thenAnswer((_) async => trend);
  }

  setUp(() {
    repo = _MockGradeRepository();
  });

  group('AssessmentsBloc.AssessmentsStarted', () {
    blocTest<AssessmentsBloc, AssessmentsState>(
      'first load fetches all three sections',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) => bloc.add(const AssessmentsStarted(childId)),
      verify: (bloc) {
        expect(bloc.state.childId, equals(childId));
        expect(bloc.state.assessmentsSection.isLoaded, isTrue);
        expect(bloc.state.summarySection.isLoaded, isTrue);
        expect(bloc.state.trendSection.isLoaded, isTrue);
      },
    );

    blocTest<AssessmentsBloc, AssessmentsState>(
      'same child id while already loaded is a no-op',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AssessmentsStarted(childId));
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const AssessmentsStarted(childId));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        // Each repo method called exactly once for the initial load only.
        verify(() => repo.getAssessments(childId)).called(1);
        verify(() => repo.getGradeSummary(childId)).called(1);
        verify(() => repo.getGradeTrend(childId)).called(1);
      },
    );

    blocTest<AssessmentsBloc, AssessmentsState>(
      'history fetch failure puts the history section in failure',
      setUp: () {
        when(() => repo.getAssessments(childId)).thenThrow(Exception('500'));
        when(
          () => repo.getGradeSummary(childId),
        ).thenAnswer((_) async => summary);
        when(() => repo.getGradeTrend(childId)).thenAnswer((_) async => trend);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AssessmentsStarted(childId)),
      verify: (bloc) {
        expect(bloc.state.assessmentsSection.isFailure, isTrue);
        expect(bloc.state.summarySection.isLoaded, isTrue);
        expect(bloc.state.trendSection.isLoaded, isTrue);
      },
    );
  });

  group('AssessmentsBloc.AssessmentsRefreshRequested', () {
    blocTest<AssessmentsBloc, AssessmentsState>(
      'refresh while already refreshing is dropped',
      setUp: () {
        when(() => repo.getAssessments(childId)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return const <QuizAttemptEntity>[];
        });
        when(() => repo.getGradeSummary(childId)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return summary;
        });
        when(() => repo.getGradeTrend(childId)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return trend;
        });
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AssessmentsRefreshRequested(childId));
        bloc.add(const AssessmentsRefreshRequested(childId));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        // Should fire only once.
        verify(() => repo.getAssessments(childId)).called(1);
      },
    );
  });

  group('AssessmentsBloc.AssessmentsRetrySectionRequested', () {
    blocTest<AssessmentsBloc, AssessmentsState>(
      'retry summary only refetches summary',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AssessmentsStarted(childId));
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(
          const AssessmentsRetrySectionRequested(AssessmentsSection.summary),
        );
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verify(() => repo.getGradeSummary(childId)).called(2);
        verify(() => repo.getAssessments(childId)).called(1);
        verify(() => repo.getGradeTrend(childId)).called(1);
      },
    );

    blocTest<AssessmentsBloc, AssessmentsState>(
      'retry without a selected child is a no-op',
      build: buildBloc,
      act: (bloc) => bloc.add(
        const AssessmentsRetrySectionRequested(AssessmentsSection.summary),
      ),
      verify: (_) {
        verifyNever(() => repo.getGradeSummary(any()));
      },
    );
  });
}
