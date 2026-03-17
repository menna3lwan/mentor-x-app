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
  }

  final NotificationRepository notificationRepository;

  Future<void> _onLoad(
    NotificationsPageLoadEvent event,
    Emitter<NotificationsPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
