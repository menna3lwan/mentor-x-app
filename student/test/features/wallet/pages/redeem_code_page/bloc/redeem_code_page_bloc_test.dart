import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/redeem_code_page/bloc/redeem_code_page_bloc.dart';

void main() {
  late MockWalletRepository walletRepository;

  setUp(() {
    walletRepository = const MockWalletRepository(delay: Duration.zero);
  });

  group('RedeemCodePageBloc', () {
    test('initial state is correct', () {
      final bloc = RedeemCodePageBloc(walletRepository: walletRepository);
      expect(bloc.state, RedeemCodePageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<RedeemCodePageBloc, RedeemCodePageState>(
      'emits [loading, loaded] when RedeemCodePageLoadEvent is added',
      build: () => RedeemCodePageBloc(walletRepository: walletRepository),
      act: (bloc) => bloc.add(const RedeemCodePageLoadEvent()),
      expect: () => [
        isA<RedeemCodePageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<RedeemCodePageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
