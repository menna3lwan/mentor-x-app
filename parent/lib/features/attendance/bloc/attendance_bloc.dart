import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

final class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final ParentPortalRepository _repository;

  AttendanceBloc({required ParentPortalRepository repository})
    : _repository = repository,
      super(const AttendanceState()) {
    on<AttendanceStarted>(_onStarted);
  }

  Future<void> _onStarted(
    AttendanceStarted event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final records = await _repository.getAttendance(childId: event.childId);
      emit(state.copyWith(isLoading: false, records: records));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }
}
