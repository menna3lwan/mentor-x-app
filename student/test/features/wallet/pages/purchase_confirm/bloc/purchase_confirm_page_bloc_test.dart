import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/purchase_confirm/bloc/purchase_confirm_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
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
  late AnalyticsService analyticsService;
  late MockWalletRepository walletRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    walletRepository = const MockWalletRepository(delay: Duration.zero);
  });

  group('PurchaseConfirmBloc', () {
    test('initial state is correct', () {
      final bloc = PurchaseConfirmBloc(walletRepository: walletRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, PurchaseConfirmState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<PurchaseConfirmBloc, PurchaseConfirmState>(
      'emits [loading, loaded] when PurchaseConfirmLoadEvent is added',
      build: () => PurchaseConfirmBloc(walletRepository: walletRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) =>
          bloc.add(const PurchaseConfirmLoadEvent(paymentId: '1')),
      expect: () => [
        isA<PurchaseConfirmState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<PurchaseConfirmState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
