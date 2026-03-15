import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/transactions_history_page/bloc/transactions_history_page_bloc.dart';

void main() {
  late MockWalletRepository walletRepository;

  setUp(() {
    walletRepository = const MockWalletRepository(delay: Duration.zero);
  });

  group('TransactionsHistoryPageBloc', () {
    test('initial state is correct', () {
      final bloc = TransactionsHistoryPageBloc(
        walletRepository: walletRepository,
      );
      expect(bloc.state, TransactionsHistoryPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<TransactionsHistoryPageBloc, TransactionsHistoryPageState>(
      'emits [loading, loaded] when TransactionsHistoryPageLoadEvent is added',
      build: () => TransactionsHistoryPageBloc(
        walletRepository: walletRepository,
      ),
      act: (bloc) => bloc.add(const TransactionsHistoryPageLoadEvent()),
      expect: () => [
        isA<TransactionsHistoryPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<TransactionsHistoryPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
