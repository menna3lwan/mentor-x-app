part of 'children_bloc.dart';

sealed class ChildrenEvent extends Equatable {
  const ChildrenEvent();

  @override
  List<Object?> get props => [];
}

final class ChildrenStarted extends ChildrenEvent {}

final class ChildrenLookupRequested extends ChildrenEvent {
  final String query;
  const ChildrenLookupRequested(this.query);

  @override
  List<Object?> get props => [query];
}

final class ChildLinkConfirmed extends ChildrenEvent {
  final String studentId;
  final String relationship;
  const ChildLinkConfirmed({
    required this.studentId,
    required this.relationship,
  });

  @override
  List<Object?> get props => [studentId, relationship];
}
