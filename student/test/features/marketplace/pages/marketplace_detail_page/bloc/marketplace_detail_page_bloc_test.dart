import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/marketplace/pages/marketplace_detail_page/bloc/marketplace_detail_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


void main() {
  late AnalyticsService analyticsService;
  late MockMarketplaceRepository marketplaceRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    marketplaceRepository = const MockMarketplaceRepository(
      delay: Duration.zero,
    );
  });

  group('MarketplaceDetailPageBloc', () {
    blocTest<MarketplaceDetailPageBloc, MarketplaceDetailPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => MarketplaceDetailPageBloc(marketplaceRepository: marketplaceRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const MarketplaceDetailPageLoadEvent('item-1')),
      expect: () => [
        isA<MarketplaceDetailPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MarketplaceDetailPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<MarketplaceDetailPageBloc, MarketplaceDetailPageState>(
      'starts with initial loading state',
      build: () => MarketplaceDetailPageBloc(marketplaceRepository: marketplaceRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
