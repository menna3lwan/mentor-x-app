import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'notifications_page_event.dart';
part 'notifications_page_state.dart';

sealed class NotificationsPagePresentationEvent {
  const NotificationsPagePresentationEvent();
}

final class NotificationsPageNavigateBack
    extends NotificationsPagePresentationEvent {
  const NotificationsPageNavigateBack();
}

final class NotificationsPageBloc
    extends Bloc<NotificationsPageEvent, NotificationsPageState>
    with
        BlocPresentationMixin<
          NotificationsPageState,
          NotificationsPagePresentationEvent
        > {
  NotificationsPageBloc({required this.notificationRepository})
    : super(NotificationsPageState.initial) {
    on<NotificationsPageLoadEvent>(_onLoad);
    on<NotificationsPageLoadMoreEvent>(_onLoadMore);
    on<NotificationsPageMarkAsReadEvent>(_onMarkAsRead);
    on<NotificationsPageMarkAllAsReadEvent>(_onMarkAllAsRead);
  }

  final NotificationRepository notificationRepository;

  Future<void> _onLoad(
    NotificationsPageLoadEvent event,
    Emitter<NotificationsPageState> emit,
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
    NotificationsPageLoadMoreEvent event,
    Emitter<NotificationsPageState> emit,
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
    NotificationsPageMarkAsReadEvent event,
    Emitter<NotificationsPageState> emit,
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
    NotificationsPageMarkAllAsReadEvent event,
    Emitter<NotificationsPageState> emit,
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
