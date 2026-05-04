import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/marketplace/pages/marketplace_grid_page/bloc/marketplace_grid_page_bloc.dart';

void main() {
  late MockMarketplaceRepository marketplaceRepository;

  setUp(() {
    marketplaceRepository = const MockMarketplaceRepository(
      delay: Duration.zero,
    );
  });

  group('MarketplaceGridPageBloc', () {
    blocTest<MarketplaceGridPageBloc, MarketplaceGridPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => MarketplaceGridPageBloc(
        marketplaceRepository: marketplaceRepository,
      ),
      act: (bloc) => bloc.add(const MarketplaceGridPageLoadEvent()),
      expect: () => [
        isA<MarketplaceGridPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MarketplaceGridPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<MarketplaceGridPageBloc, MarketplaceGridPageState>(
      'starts with initial loading state',
      build: () => MarketplaceGridPageBloc(
        marketplaceRepository: marketplaceRepository,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
