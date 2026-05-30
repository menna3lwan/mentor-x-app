import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../domain/usecases/notification_usecases.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

sealed class NotificationsPresentationEvent {
  const NotificationsPresentationEvent();
}

final class NotificationsFailurePresentationEvent
    extends NotificationsPresentationEvent {
  final String message;

  const NotificationsFailurePresentationEvent({required this.message});
}

final class NotificationMarkedReadPresentationEvent
    extends NotificationsPresentationEvent {
  const NotificationMarkedReadPresentationEvent();
}

final class NotificationsMarkedAllReadPresentationEvent
    extends NotificationsPresentationEvent {
  const NotificationsMarkedAllReadPresentationEvent();
}

final class NotificationsBloc
    extends Bloc<NotificationsEvent, NotificationsState>
    with BlocPresentationMixin<NotificationsState, NotificationsPresentationEvent> {
  static const int _pageSize = 20;

  final GetParentNotificationsUseCase _getNotifications;
  final MarkParentNotificationAsReadUseCase _markAsRead;
  final MarkAllParentNotificationsAsReadUseCase _markAllAsRead;
  final GetParentUnreadNotificationsCountUseCase _getUnreadCount;

  NotificationsBloc({
    required GetParentNotificationsUseCase getNotifications,
    required MarkParentNotificationAsReadUseCase markAsRead,
    required MarkAllParentNotificationsAsReadUseCase markAllAsRead,
    required GetParentUnreadNotificationsCountUseCase getUnreadCount,
  })  : _getNotifications = getNotifications,
        _markAsRead = markAsRead,
        _markAllAsRead = markAllAsRead,
        _getUnreadCount = getUnreadCount,
        super(NotificationsState.initial()) {
    on<NotificationsStarted>(_onStarted);
    on<NotificationsRefreshRequested>(_onRefreshRequested);
    on<NotificationsLoadMoreRequested>(_onLoadMoreRequested);
    on<NotificationMarkReadRequested>(_onMarkReadRequested);
    on<NotificationsMarkAllReadRequested>(_onMarkAllReadRequested);
  }

  Future<void> _onStarted(
    NotificationsStarted event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.isLoading ||
        state.notifications.isNotEmpty ||
        (!state.hasMore && state.errorMessage == null)) {
      return;
    }
    await _loadFirstPage(emit);
  }

  Future<void> _onRefreshRequested(
    NotificationsRefreshRequested event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));
    await _loadFirstPage(emit, preserveList: true);
    if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _onLoadMoreRequested(
    NotificationsLoadMoreRequested event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoadingMore: true));
    try {
      final nextPage = state.page + 1;
      final more = await _getNotifications(
        paginationInfo: const MentorXPaginationInfo(
          limit: _pageSize,
        ).copyWithPage(nextPage),
      );
      emit(state.copyWith(
        notifications: [...state.notifications, ...more],
        page: nextPage,
        hasMore: more.length >= _pageSize,
        isLoadingMore: false,
      ));
    } catch (error) {
      final message = _describe(error);
      emit(state.copyWith(isLoadingMore: false, errorMessage: message));
      emitPresentation(NotificationsFailurePresentationEvent(message: message));
    }
  }

  Future<void> _onMarkReadRequested(
    NotificationMarkReadRequested event,
    Emitter<NotificationsState> emit,
  ) async {
    final current = state.notifications
        .where((notification) => notification.id == event.notificationId)
        .firstOrNull;
    if (current == null || current.isRead) return;

    try {
      await _markAsRead(event.notificationId);
      final updated = state.notifications.map((notification) {
        if (notification.id != event.notificationId) return notification;
        return notification.copyWith(isRead: true, readAt: DateTime.now());
      }).toList(growable: false);
      emit(state.copyWith(
        notifications: updated,
        unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
      ));
      emitPresentation(const NotificationMarkedReadPresentationEvent());
    } catch (error) {
      final message = _describe(error);
      emit(state.copyWith(errorMessage: message));
      emitPresentation(NotificationsFailurePresentationEvent(message: message));
    }
  }

  Future<void> _onMarkAllReadRequested(
    NotificationsMarkAllReadRequested event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.notifications.every((notification) => notification.isRead)) {
      return;
    }

    emit(state.copyWith(isMarkingAllRead: true));
    try {
      await _markAllAsRead();
      final now = DateTime.now();
      final updated = state.notifications
          .map((notification) => notification.isRead
              ? notification
              : notification.copyWith(isRead: true, readAt: now))
          .toList(growable: false);
      emit(state.copyWith(
        notifications: updated,
        unreadCount: 0,
        isMarkingAllRead: false,
      ));
      emitPresentation(const NotificationsMarkedAllReadPresentationEvent());
    } catch (error) {
      final message = _describe(error);
      emit(state.copyWith(isMarkingAllRead: false, errorMessage: message));
      emitPresentation(NotificationsFailurePresentationEvent(message: message));
    }
  }

  Future<void> _loadFirstPage(
    Emitter<NotificationsState> emit, {
    bool preserveList = false,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      notifications: preserveList ? state.notifications : const [],
    ));

    try {
      final results = await Future.wait([
        _getNotifications(
          paginationInfo: const MentorXPaginationInfo(
            limit: _pageSize,
            page: 1,
          ),
        ),
        _getUnreadCount(),
      ]);
      final notifications = results[0] as List<NotificationEntity>;
      final unreadCount = results[1] as int;
      emit(state.copyWith(
        notifications: notifications,
        unreadCount: unreadCount,
        page: 1,
        hasMore: notifications.length >= _pageSize,
        isLoading: false,
      ));
    } catch (error) {
      final message = _describe(error);
      emit(state.copyWith(isLoading: false, errorMessage: message));
      emitPresentation(NotificationsFailurePresentationEvent(message: message));
    }
  }

  String _describe(Object error) {
    if (error is MentorXException) {
      return error.message ?? error.toString();
    }
    if (error is HttpClientResponse) {
      return error.exception?.message ?? 'Request failed (${error.statusCode})';
    }
    return error.toString();
  }
}

extension on MentorXPaginationInfo {
  MentorXPaginationInfo copyWithPage(int page) {
    return MentorXPaginationInfo(limit: limit, page: page, cursor: cursor);
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    return iterator.current;
  }
}
