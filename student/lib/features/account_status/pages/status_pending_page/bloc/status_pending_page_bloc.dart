import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_pending_page_event.dart';
part 'status_pending_page_state.dart';

final class StatusPendingPageBloc
    extends Bloc<StatusPendingPageEvent, StatusPendingPageState> {
  StatusPendingPageBloc() : super(const StatusPendingPageState()) {
    on<StatusPendingPageInitialized>(_onInitialized);
  }

  void _onInitialized(
    StatusPendingPageInitialized event,
    Emitter<StatusPendingPageState> emit,
  ) {
    emit(state.copyWith(status: StatusPendingPageStatus.ready));
  }
}
