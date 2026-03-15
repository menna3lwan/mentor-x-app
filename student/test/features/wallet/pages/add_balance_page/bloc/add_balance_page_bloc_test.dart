import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/add_balance_page/bloc/add_balance_page_bloc.dart';

void main() {
  late MockWalletRepository walletRepository;

  setUp(() {
    walletRepository = const MockWalletRepository(delay: Duration.zero);
  });

  group('AddBalancePageBloc', () {
    test('initial state is correct', () {
      final bloc = AddBalancePageBloc(walletRepository: walletRepository);
      expect(bloc.state, AddBalancePageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<AddBalancePageBloc, AddBalancePageState>(
      'emits [loading, loaded] when AddBalancePageLoadEvent is added',
      build: () => AddBalancePageBloc(walletRepository: walletRepository),
      act: (bloc) => bloc.add(const AddBalancePageLoadEvent()),
      expect: () => [
        isA<AddBalancePageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AddBalancePageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
