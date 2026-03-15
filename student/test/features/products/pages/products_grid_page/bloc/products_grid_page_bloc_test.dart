import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/products/pages/products_grid_page/bloc/products_grid_page_bloc.dart';

void main() {
  late MockMarketplaceRepository marketplaceRepository;

  setUp(() {
    marketplaceRepository = const MockMarketplaceRepository(
      delay: Duration.zero,
    );
  });

  group('ProductsGridPageBloc', () {
    blocTest<ProductsGridPageBloc, ProductsGridPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => ProductsGridPageBloc(
        marketplaceRepository: marketplaceRepository,
      ),
      act: (bloc) => bloc.add(const ProductsGridPageLoadEvent()),
      expect: () => [
        isA<ProductsGridPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<ProductsGridPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<ProductsGridPageBloc, ProductsGridPageState>(
      'starts with initial loading state',
      build: () => ProductsGridPageBloc(
        marketplaceRepository: marketplaceRepository,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
