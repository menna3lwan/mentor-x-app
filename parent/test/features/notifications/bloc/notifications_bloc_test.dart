import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/notifications/notifications.dart';

class _MockNotificationRepository extends Mock
    implements NotificationRepository {}

void main() {
  late _MockNotificationRepository repository;

  final unreadNotification = NotificationEntity(
    id: 'notification-1',
    title: 'Grade updated',
    message: 'Your child has a new grade.',
    type: NotificationType.quiz,
    createdAt: DateTime(2026),
  );

  NotificationsBloc buildBloc() {
    return NotificationsBloc(
      getNotifications: GetParentNotificationsUseCase(repository),
      markAsRead: MarkParentNotificationAsReadUseCase(repository),
      markAllAsRead: MarkAllParentNotificationsAsReadUseCase(repository),
      getUnreadCount: GetParentUnreadNotificationsCountUseCase(repository),
    );
  }

  void stubInitialLoad() {
    when(
      () => repository.getNotifications(
        paginationInfo: any(named: 'paginationInfo'),
      ),
    ).thenAnswer((_) async => [unreadNotification]);
    when(repository.getUnreadCount).thenAnswer((_) async => 1);
  }

  setUpAll(() {
    registerFallbackValue(const MentorXPaginationInfo());
  });

  setUp(() {
    repository = _MockNotificationRepository();
  });

  blocTest<NotificationsBloc, NotificationsState>(
    'loads notifications and unread count on start',
    setUp: stubInitialLoad,
    build: buildBloc,
    act: (bloc) => bloc.add(const NotificationsStarted()),
    verify: (bloc) {
      expect(bloc.state.notifications, equals([unreadNotification]));
      expect(bloc.state.unreadCount, equals(1));
      expect(bloc.state.isLoading, isFalse);
    },
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'mark read updates the list and decrements unread count',
    setUp: () {
      when(
        () => repository.markAsRead(unreadNotification.id),
      ).thenAnswer((_) async {});
    },
    build: buildBloc,
    seed: () => NotificationsState.initial().copyWith(
      notifications: [unreadNotification],
      unreadCount: 1,
    ),
    act: (bloc) => bloc.add(
      NotificationMarkReadRequested(unreadNotification.id),
    ),
    verify: (bloc) {
      expect(bloc.state.notifications.single.isRead, isTrue);
      expect(bloc.state.unreadCount, equals(0));
      verify(() => repository.markAsRead(unreadNotification.id)).called(1);
    },
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'mark all read updates all unread items and clears unread count',
    setUp: () {
      when(repository.markAllAsRead).thenAnswer((_) async {});
    },
    build: buildBloc,
    seed: () => NotificationsState.initial().copyWith(
      notifications: [unreadNotification],
      unreadCount: 1,
    ),
    act: (bloc) => bloc.add(const NotificationsMarkAllReadRequested()),
    verify: (bloc) {
      expect(bloc.state.notifications.every((item) => item.isRead), isTrue);
      expect(bloc.state.unreadCount, equals(0));
      verify(repository.markAllAsRead).called(1);
    },
  );
}
