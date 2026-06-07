import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/payment_success/bloc/payment_success_bloc.dart';

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

  setUp(() {
    analyticsService = MockAnalyticsService();
  });


  group('PaymentSuccessBloc', () {
    test('initial state is correct', () {
      final bloc = PaymentSuccessBloc(analyticsService: analyticsService);
      expect(bloc.state, PaymentSuccessState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<PaymentSuccessBloc, PaymentSuccessState>(
      'emits [loading, loaded] when PaymentSuccessLoadEvent is added',
      build: () => PaymentSuccessBloc(analyticsService: analyticsService),
      act: (bloc) => bloc.add(const PaymentSuccessLoadEvent()),
      expect: () => [
        isA<PaymentSuccessState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<PaymentSuccessState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
