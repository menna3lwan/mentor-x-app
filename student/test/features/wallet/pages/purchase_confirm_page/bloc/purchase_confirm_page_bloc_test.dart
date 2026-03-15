import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/purchase_confirm_page/bloc/purchase_confirm_page_bloc.dart';

void main() {
  late MockWalletRepository walletRepository;

  setUp(() {
    walletRepository = const MockWalletRepository(delay: Duration.zero);
  });

  group('PurchaseConfirmPageBloc', () {
    test('initial state is correct', () {
      final bloc = PurchaseConfirmPageBloc(
        walletRepository: walletRepository,
      );
      expect(bloc.state, PurchaseConfirmPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<PurchaseConfirmPageBloc, PurchaseConfirmPageState>(
      'emits [loading, loaded] when PurchaseConfirmPageLoadEvent is added',
      build: () => PurchaseConfirmPageBloc(
        walletRepository: walletRepository,
      ),
      act: (bloc) => bloc.add(const PurchaseConfirmPageLoadEvent()),
      expect: () => [
        isA<PurchaseConfirmPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<PurchaseConfirmPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
