import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/transactions_history/bloc/transactions_history_bloc.dart';

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
  late MockWalletRepository walletRepository;
  late _MockAnalyticsService analyticsService;

  setUp(() {
    walletRepository = const MockWalletRepository(delay: Duration.zero);
    analyticsService = _MockAnalyticsService();
  });

  group('TransactionsHistoryBloc', () {
    test('initial state is correct', () {
      final bloc = TransactionsHistoryBloc(
        walletRepository: walletRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, TransactionsHistoryState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<TransactionsHistoryBloc, TransactionsHistoryState>(
      'emits [loading, loaded] when TransactionsHistoryLoadEvent is added',
      build: () => TransactionsHistoryBloc(
        walletRepository: walletRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const TransactionsHistoryLoadEvent()),
      expect: () => [
        isA<TransactionsHistoryState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<TransactionsHistoryState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
