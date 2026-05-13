import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/purchase_confirm_page/bloc/purchase_confirm_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


void main() {
  late AnalyticsService analyticsService;
  late MockWalletRepository walletRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    walletRepository = const MockWalletRepository(delay: Duration.zero);
  });

  group('PurchaseConfirmPageBloc', () {
    test('initial state is correct', () {
      final bloc = PurchaseConfirmPageBloc(walletRepository: walletRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, PurchaseConfirmPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<PurchaseConfirmPageBloc, PurchaseConfirmPageState>(
      'emits [loading, loaded] when PurchaseConfirmPageLoadEvent is added',
      build: () => PurchaseConfirmPageBloc(walletRepository: walletRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) =>
          bloc.add(const PurchaseConfirmPageLoadEvent(paymentId: '1')),
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
