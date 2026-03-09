import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_blocked_page_event.dart';
part 'status_blocked_page_state.dart';

final class StatusBlockedPageBloc
    extends Bloc<StatusBlockedPageEvent, StatusBlockedPageState> {
  StatusBlockedPageBloc() : super(const StatusBlockedPageState()) {
    on<StatusBlockedPageInitialized>(_onInitialized);
  }

  void _onInitialized(
    StatusBlockedPageInitialized event,
    Emitter<StatusBlockedPageState> emit,
  ) {
    emit(state.copyWith(status: StatusBlockedPageStatus.ready));
  }
}
