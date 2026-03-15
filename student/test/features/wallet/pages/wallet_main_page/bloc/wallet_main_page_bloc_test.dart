import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/wallet_main_page/bloc/wallet_main_page_bloc.dart';

void main() {
  late MockWalletRepository walletRepository;

  setUp(() {
    walletRepository = const MockWalletRepository(delay: Duration.zero);
  });

  group('WalletMainPageBloc', () {
    test('initial state is correct', () {
      final bloc = WalletMainPageBloc(walletRepository: walletRepository);
      expect(bloc.state, WalletMainPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<WalletMainPageBloc, WalletMainPageState>(
      'emits [loading, loaded] when WalletMainPageLoadEvent is added',
      build: () => WalletMainPageBloc(walletRepository: walletRepository),
      act: (bloc) => bloc.add(const WalletMainPageLoadEvent()),
      expect: () => [
        isA<WalletMainPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalletMainPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
