import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/wallet_main/bloc/wallet_main_bloc.dart';

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

  group('WalletMainBloc', () {
    test('initial state is correct', () {
      final bloc = WalletMainBloc(
        walletRepository: walletRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, WalletMainState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<WalletMainBloc, WalletMainState>(
      'emits [loading, loaded] when WalletMainLoadEvent is added',
      build: () => WalletMainBloc(
        walletRepository: walletRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const WalletMainLoadEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<WalletMainState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<WalletMainState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
