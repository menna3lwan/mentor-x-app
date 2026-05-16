import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/marketplace/pages/marketplace_cart/bloc/marketplace_cart_page_bloc.dart';

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
  late MockMarketplaceRepository marketplaceRepository;
  late MockWalletRepository walletRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    marketplaceRepository = const MockMarketplaceRepository(
      delay: Duration.zero,
    );
    walletRepository = const MockWalletRepository(
      delay: Duration.zero,
    );
  });

  group('MarketplaceCartPageBloc', () {
    blocTest<MarketplaceCartPageBloc, MarketplaceCartPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => MarketplaceCartPageBloc(marketplaceRepository: marketplaceRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const MarketplaceCartPageLoadEvent()),
      expect: () => [
        isA<MarketplaceCartPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MarketplaceCartPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<MarketplaceCartPageBloc, MarketplaceCartPageState>(
      'starts with initial loading state',
      build: () => MarketplaceCartPageBloc(marketplaceRepository: marketplaceRepository,
        walletRepository: walletRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
