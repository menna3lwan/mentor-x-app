import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_notification_repository/mock_notification_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/notifications/pages/notifications_page/bloc/notifications_page_bloc.dart';

void main() {
  late MockNotificationRepository notificationRepository;

  setUp(() {
    notificationRepository = const MockNotificationRepository(
      delay: Duration.zero,
    );
  });

  group('NotificationsPageBloc', () {
    test('initial state is correct', () {
      final bloc = NotificationsPageBloc(
        notificationRepository: notificationRepository,
      );
      expect(bloc.state, NotificationsPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<NotificationsPageBloc, NotificationsPageState>(
      'emits [loading, loaded] when NotificationsPageLoadEvent is added',
      build: () => NotificationsPageBloc(
        notificationRepository: notificationRepository,
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
