import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_marketplace_repository/mock_marketplace_repository.dart';
import 'package:mock_wallet_repository/mock_wallet_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/products/pages/shopping_cart_page/bloc/shopping_cart_page_bloc.dart';

void main() {
  late MockMarketplaceRepository marketplaceRepository;
  late MockWalletRepository walletRepository;

  setUp(() {
    marketplaceRepository = const MockMarketplaceRepository(
      delay: Duration.zero,
    );
    walletRepository = const MockWalletRepository(
      delay: Duration.zero,
    );
  });

  group('ShoppingCartPageBloc', () {
    blocTest<ShoppingCartPageBloc, ShoppingCartPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => ShoppingCartPageBloc(
        marketplaceRepository: marketplaceRepository,
        walletRepository: walletRepository,
      ),
      act: (bloc) => bloc.add(const ShoppingCartPageLoadEvent()),
      expect: () => [
        isA<ShoppingCartPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<ShoppingCartPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<ShoppingCartPageBloc, ShoppingCartPageState>(
      'starts with initial loading state',
      build: () => ShoppingCartPageBloc(
        marketplaceRepository: marketplaceRepository,
        walletRepository: walletRepository,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
