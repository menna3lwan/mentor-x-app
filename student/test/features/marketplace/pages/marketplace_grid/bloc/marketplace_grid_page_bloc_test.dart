import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/marketplace/pages/marketplace_grid/bloc/marketplace_grid_bloc.dart';

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
  late MockMarketplaceRepository marketplaceRepository;
  late _MockAnalyticsService analyticsService;

  setUp(() {
    marketplaceRepository = const MockMarketplaceRepository(delay: Duration.zero);
    analyticsService = _MockAnalyticsService();
  });

  group('MarketplaceGridBloc', () {
    blocTest<MarketplaceGridBloc, MarketplaceGridState>(
      'emits [loading, loaded] when load event is added',
      build: () => MarketplaceGridBloc(
        marketplaceRepository: marketplaceRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const MarketplaceGridLoadEvent()),
      expect: () => [
        isA<MarketplaceGridState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MarketplaceGridState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<MarketplaceGridBloc, MarketplaceGridState>(
      'starts with initial loading state',
      build: () => MarketplaceGridBloc(
        marketplaceRepository: marketplaceRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
