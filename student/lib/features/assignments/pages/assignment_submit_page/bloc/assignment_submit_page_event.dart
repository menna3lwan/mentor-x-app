part of 'assignment_submit_page_bloc.dart';

sealed class AssignmentSubmitPageEvent extends Equatable {
  const AssignmentSubmitPageEvent();

  @override
  List<Object?> get props => [];
}

final class AssignmentSubmitPageLoadEvent extends AssignmentSubmitPageEvent {
  const AssignmentSubmitPageLoadEvent();
}
