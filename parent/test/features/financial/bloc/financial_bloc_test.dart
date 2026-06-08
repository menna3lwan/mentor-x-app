import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/financial/bloc/financial_bloc.dart';

class _MockFinancialRepository extends Mock
    implements ParentFinancialRepository {}

void main() {
  late _MockFinancialRepository repo;
  const childId = 'child-1';

  const summary = WalletSummaryEntity(
    walletBalance: 250.0,
    spentThisMonth: 50.0,
    points: 120,
  );

  const analytics = ParentWalletAnalyticsEntity(
    monthlySpending: [],
    categoryBreakdown: {},
  );

  FinancialBloc buildBloc() => FinancialBloc(repository: repo);

  void stubAllSuccess() {
    when(
      () => repo.getTransactions(childId),
    ).thenAnswer((_) async => const <WalletTransactionEntity>[]);
    when(() => repo.getWalletSummary(childId)).thenAnswer((_) async => summary);
    when(
      () => repo.getPayments(childId),
    ).thenAnswer((_) async => const <PaymentEntity>[]);
    when(
      () => repo.getWalletAnalytics(childId),
    ).thenAnswer((_) async => analytics);
  }

  setUp(() {
    repo = _MockFinancialRepository();
  });

  group('FinancialBloc.FinancialStarted', () {
    blocTest<FinancialBloc, FinancialState>(
      'loads four sections on first start',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) => bloc.add(const FinancialStarted(childId: childId)),
      verify: (bloc) {
        expect(bloc.state.childId, equals(childId));
        expect(bloc.state.transactionsSection.isLoaded, isTrue);
        expect(bloc.state.summarySection.isLoaded, isTrue);
        expect(bloc.state.paymentsSection.isLoaded, isTrue);
        expect(bloc.state.analyticsSection.isLoaded, isTrue);
      },
    );

    blocTest<FinancialBloc, FinancialState>(
      'empty childId fires invalidChild failure',
      build: buildBloc,
      act: (bloc) => bloc.add(const FinancialStarted(childId: '')),
      verify: (bloc) {
        expect(bloc.state.transactionsSection.isFailure, isTrue);
        verifyNever(() => repo.getTransactions(any()));
      },
    );

    blocTest<FinancialBloc, FinancialState>(
      'repeated start with same child is a no-op',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const FinancialStarted(childId: childId));
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const FinancialStarted(childId: childId));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verify(() => repo.getTransactions(childId)).called(1);
        verify(() => repo.getWalletSummary(childId)).called(1);
      },
    );
  });

  group('FinancialBloc.FinancialRefreshRequested', () {
    blocTest<FinancialBloc, FinancialState>(
      'rapid refresh taps are dropped',
      setUp: () {
        when(() => repo.getTransactions(childId)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return const <WalletTransactionEntity>[];
        });
        when(() => repo.getWalletSummary(childId)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return summary;
        });
        when(() => repo.getPayments(childId)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return const <PaymentEntity>[];
        });
        when(() => repo.getWalletAnalytics(childId)).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 30));
          return analytics;
        });
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const FinancialRefreshRequested(childId: childId));
        bloc.add(const FinancialRefreshRequested(childId: childId));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verify(() => repo.getTransactions(childId)).called(1);
      },
    );

    blocTest<FinancialBloc, FinancialState>(
      'empty childId on refresh is a no-op',
      build: buildBloc,
      act: (bloc) => bloc.add(const FinancialRefreshRequested(childId: '')),
      verify: (_) {
        verifyNever(() => repo.getTransactions(any()));
      },
    );
  });

  group('FinancialBloc.FinancialRetrySectionRequested', () {
    blocTest<FinancialBloc, FinancialState>(
      'retry summary only refetches summary',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const FinancialStarted(childId: childId));
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(
          const FinancialRetrySectionRequested(FinancialSection.summary),
        );
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verify(() => repo.getWalletSummary(childId)).called(2);
        verify(() => repo.getTransactions(childId)).called(1);
      },
    );

    blocTest<FinancialBloc, FinancialState>(
      'retry without a selected child is a no-op',
      build: buildBloc,
      act: (bloc) => bloc.add(
        const FinancialRetrySectionRequested(FinancialSection.transactions),
      ),
      verify: (_) {
        verifyNever(() => repo.getTransactions(any()));
      },
    );
  });
}
