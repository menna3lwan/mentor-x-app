import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/add_balance/bloc/add_balance_bloc.dart';

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

  group('AddBalanceBloc', () {
    test('initial state is correct', () {
      final bloc = AddBalanceBloc(walletRepository: walletRepository, analyticsService: analyticsService);
      expect(bloc.state, AddBalanceState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<AddBalanceBloc, AddBalanceState>(
      'emits [loading, loaded] when AddBalanceLoadEvent is added',
      build: () => AddBalanceBloc(walletRepository: walletRepository, analyticsService: analyticsService),
      act: (bloc) => bloc.add(const AddBalanceLoadEvent()),
      expect: () => [
        isA<AddBalanceState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AddBalanceState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
