import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_rejected_page_event.dart';
part 'status_rejected_page_state.dart';

final class StatusRejectedPageBloc
    extends Bloc<StatusRejectedPageEvent, StatusRejectedPageState> {
  StatusRejectedPageBloc() : super(const StatusRejectedPageState()) {
    on<StatusRejectedPageInitialized>(_onInitialized);
  }

  void _onInitialized(
    StatusRejectedPageInitialized event,
    Emitter<StatusRejectedPageState> emit,
  ) {
    emit(state.copyWith(status: StatusRejectedPageStatus.ready));
  }
}
