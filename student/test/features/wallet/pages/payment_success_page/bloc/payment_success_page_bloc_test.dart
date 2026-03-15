import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/payment_success_page/bloc/payment_success_page_bloc.dart';

void main() {
  group('PaymentSuccessPageBloc', () {
    test('initial state is correct', () {
      final bloc = PaymentSuccessPageBloc();
      expect(bloc.state, PaymentSuccessPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<PaymentSuccessPageBloc, PaymentSuccessPageState>(
      'emits [loading, loaded] when PaymentSuccessPageLoadEvent is added',
      build: () => PaymentSuccessPageBloc(),
      act: (bloc) => bloc.add(const PaymentSuccessPageLoadEvent()),
      expect: () => [
        isA<PaymentSuccessPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<PaymentSuccessPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
