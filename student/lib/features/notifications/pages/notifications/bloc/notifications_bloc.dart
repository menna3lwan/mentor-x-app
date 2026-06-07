import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

sealed class NotificationsPresentationEvent {
  const NotificationsPresentationEvent();
}

final class NotificationsNavigateBack
    extends NotificationsPresentationEvent {
  const NotificationsNavigateBack();
}

final class NotificationsBloc
    extends Bloc<NotificationsEvent, NotificationsState>
    with
        BlocPresentationMixin<
          NotificationsState,
          NotificationsPresentationEvent
        > {
  NotificationsBloc({
    required this.notificationRepository,
    required this.analyticsService,
  }) : super(NotificationsState.initial) {
    on<NotificationsLoadEvent>(_onLoad);
    on<NotificationsLoadMoreEvent>(_onLoadMore);
    on<NotificationsMarkAsReadEvent>(_onMarkAsRead);
    on<NotificationsMarkAllAsReadEvent>(_onMarkAllAsRead);
  }

  final NotificationRepository notificationRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    NotificationsLoadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: const MentorXNullableValue(null),
        notifications: [],
        currentPage: 0,
        hasMore: true,
      ),
    );

    try {
      final notifications = await notificationRepository.getNotifications(
        paginationInfo: const MentorXPaginationInfo(page: 0, limit: 20),
      );

      analyticsService.logEvent(name: AnalyticsEvents.notificationsViewed);

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          notifications: notifications,
          hasMore: notifications.length >= 20,
          currentPage: 0,
        ),
      );
    } on MentorXException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.toString()),
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    NotificationsLoadMoreEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    if (!state.hasMore || state.loadingState == LoadingState.loading) return;

    final nextPage = state.currentPage + 1;

    try {
      final moreNotifications = await notificationRepository.getNotifications(
        paginationInfo: MentorXPaginationInfo(page: nextPage, limit: 20),
      );

      emit(
        state.copyWith(
          notifications: [...state.notifications, ...moreNotifications],
          hasMore: moreNotifications.length >= 20,
          currentPage: nextPage,
        ),
      );
    } catch (e) {
      // Ignore pagination errors
    }
  }

  Future<void> _onMarkAsRead(
    NotificationsMarkAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      await notificationRepository.markAsRead(event.notificationId);

      final updatedList = state.notifications.map((n) {
        if (n.id == event.notificationId) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();

      emit(state.copyWith(notifications: updatedList));
    } catch (e) {
      // Ignore read errors
    }
  }

  Future<void> _onMarkAllAsRead(
    NotificationsMarkAllAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      await notificationRepository.markAllAsRead();

      final updatedList = state.notifications.map((n) {
        return n.copyWith(isRead: true);
      }).toList();

      emit(state.copyWith(notifications: updatedList));
    } catch (e) {
      // Ignore read errors
    }
  }
}
