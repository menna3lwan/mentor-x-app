import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/marketplace/pages/marketplace_detail/bloc/marketplace_detail_bloc.dart';

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

  setUp(() {
    analyticsService = MockAnalyticsService();
    marketplaceRepository = const MockMarketplaceRepository(
      delay: Duration.zero,
    );
  });

  group('MarketplaceDetailBloc', () {
    blocTest<MarketplaceDetailBloc, MarketplaceDetailState>(
      'emits [loading, loaded] when load event is added',
      build: () => MarketplaceDetailBloc(marketplaceRepository: marketplaceRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const MarketplaceDetailLoadEvent('item-1')),
      expect: () => [
        isA<MarketplaceDetailState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MarketplaceDetailState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<MarketplaceDetailBloc, MarketplaceDetailState>(
      'starts with initial loading state',
      build: () => MarketplaceDetailBloc(marketplaceRepository: marketplaceRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
