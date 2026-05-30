import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'notifications_badge_state.dart';

final class NotificationsBadgeCubit extends Cubit<NotificationsBadgeState> {
  final NotificationRepository _notificationRepository;

  NotificationsBadgeCubit({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository,
       super(NotificationsBadgeState.initial());

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final count = await _notificationRepository.getUnreadCount();
      emit(state.copyWith(count: count, isLoading: false));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: _describe(error),
        ),
      );
    }
  }

  void setCount(int count) {
    emit(state.copyWith(count: count < 0 ? 0 : count, errorMessage: null));
  }

  void decrement() {
    setCount(state.count - 1);
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
