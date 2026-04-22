part of 'children_bloc.dart';

abstract class ChildrenEvent extends Equatable {
  const ChildrenEvent();

  @override
  List<Object?> get props => [];
}

class ChildrenStarted extends ChildrenEvent {}

class ChildrenLookupRequested extends ChildrenEvent {
  final String query;
  const ChildrenLookupRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class ChildLinkConfirmed extends ChildrenEvent {
  final String studentId;
  final String relationship;
  const ChildLinkConfirmed({
    required this.studentId,
    required this.relationship,
  });

  @override
  List<Object?> get props => [studentId, relationship];
}
