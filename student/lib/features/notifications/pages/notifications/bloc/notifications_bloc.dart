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
  static final MentorXLogger _logger = MentorXLogger('NotificationsBloc');

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
    _logger.info('_onLoad entered');
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

      _logger.info('_onLoad success: loaded ${notifications.length} notifications');
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          notifications: notifications,
          hasMore: notifications.length >= 20,
          currentPage: 0,
        ),
      );
    } on MentorXException catch (e, s) {
      _logger.error('_onLoad MentorXException', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e, s) {
      _logger.error('_onLoad unknown error', e, s);
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
    _logger.info('_onLoadMore entered (hasMore: ${state.hasMore}, loadingState: ${state.loadingState})');
    if (!state.hasMore || state.loadingState == LoadingState.loading) {
      _logger.info('_onLoadMore early exit: no more data or currently loading');
      return;
    }

    final nextPage = state.currentPage + 1;

    try {
      final moreNotifications = await notificationRepository.getNotifications(
        paginationInfo: MentorXPaginationInfo(page: nextPage, limit: 20),
      );

      _logger.info('_onLoadMore success: loaded ${moreNotifications.length} more notifications');
      emit(
        state.copyWith(
          notifications: [...state.notifications, ...moreNotifications],
          hasMore: moreNotifications.length >= 20,
          currentPage: nextPage,
        ),
      );
    } catch (e, s) {
      _logger.error('_onLoadMore error (suppressed)', e, s);
      // Ignore pagination errors
    }
  }

  Future<void> _onMarkAsRead(
    NotificationsMarkAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    _logger.info('_onMarkAsRead entered for id: ${event.notificationId}');
    try {
      await notificationRepository.markAsRead(event.notificationId);

      final updatedList = state.notifications.map((n) {
        if (n.id == event.notificationId) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();

      _logger.info('_onMarkAsRead success');
      emit(state.copyWith(notifications: updatedList));
    } catch (e, s) {
      _logger.error('_onMarkAsRead error (suppressed)', e, s);
      // Ignore read errors
    }
  }

  Future<void> _onMarkAllAsRead(
    NotificationsMarkAllAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    _logger.info('_onMarkAllAsRead entered');
    try {
      await notificationRepository.markAllAsRead();

      final updatedList = state.notifications.map((n) {
        return n.copyWith(isRead: true);
      }).toList();

      _logger.info('_onMarkAllAsRead success');
      emit(state.copyWith(notifications: updatedList));
    } catch (e, s) {
      _logger.error('_onMarkAllAsRead error (suppressed)', e, s);
      // Ignore read errors
    }
  }
}
