import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_notification_repository/mock_notification_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/notifications/pages/notifications_page/bloc/notifications_page_bloc.dart';

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
  late MockNotificationRepository notificationRepository;
  late _MockAnalyticsService analyticsService;

  setUp(() {
    notificationRepository = const MockNotificationRepository(
      delay: Duration.zero,
    );
    analyticsService = _MockAnalyticsService();
  });

  group('NotificationsPageBloc', () {
    test('initial state is correct', () {
      final bloc = NotificationsPageBloc(
        notificationRepository: notificationRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, NotificationsPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<NotificationsPageBloc, NotificationsPageState>(
      'emits [loading, loaded] when NotificationsPageLoadEvent is added',
      build: () => NotificationsPageBloc(
        notificationRepository: notificationRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const NotificationsPageLoadEvent()),
      expect: () => [
        isA<NotificationsPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<NotificationsPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
