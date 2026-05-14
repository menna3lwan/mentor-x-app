import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/wallet/pages/payment_success_page/bloc/payment_success_page_bloc.dart';

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


  group('PaymentSuccessPageBloc', () {
    test('initial state is correct', () {
      final bloc = PaymentSuccessPageBloc(analyticsService: analyticsService);
      expect(bloc.state, PaymentSuccessPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<PaymentSuccessPageBloc, PaymentSuccessPageState>(
      'emits [loading, loaded] when PaymentSuccessPageLoadEvent is added',
      build: () => PaymentSuccessPageBloc(analyticsService: analyticsService),
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
