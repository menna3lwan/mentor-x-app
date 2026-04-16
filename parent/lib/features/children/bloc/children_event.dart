part of 'children_bloc.dart';

sealed class ChildrenEvent extends Equatable {
  const ChildrenEvent();

  @override
  List<Object?> get props => [];
}

final class ChildrenStarted extends ChildrenEvent {
  const ChildrenStarted();
}

final class ChildrenSwitched extends ChildrenEvent {
  final String childId;

  const ChildrenSwitched(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class ChildrenLinked extends ChildrenEvent {
  final String query;
  final String relationship;

  const ChildrenLinked({required this.query, required this.relationship});

  @override
  List<Object?> get props => [query, relationship];
}

final class ChildrenUnlinked extends ChildrenEvent {
  final String childId;

  const ChildrenUnlinked(this.childId);

  @override
  List<Object?> get props => [childId];
}
