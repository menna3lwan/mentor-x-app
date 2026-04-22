import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/products/pages/product_detail_page/bloc/product_detail_page_bloc.dart';

void main() {
  late MockMarketplaceRepository marketplaceRepository;

  setUp(() {
    marketplaceRepository = const MockMarketplaceRepository(
      delay: Duration.zero,
    );
  });

  group('ProductDetailPageBloc', () {
    blocTest<ProductDetailPageBloc, ProductDetailPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => ProductDetailPageBloc(
        marketplaceRepository: marketplaceRepository,
      ),
      act: (bloc) => bloc.add(const ProductDetailPageLoadEvent('item-1')),
      expect: () => [
        isA<ProductDetailPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<ProductDetailPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<ProductDetailPageBloc, ProductDetailPageState>(
      'starts with initial loading state',
      build: () => ProductDetailPageBloc(
        marketplaceRepository: marketplaceRepository,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
