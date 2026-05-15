part of 'children_bloc.dart';

sealed class ChildrenEvent extends Equatable {
  const ChildrenEvent();

  @override
  List<Object?> get props => [];
}

/// First entry to the children-management surface.
final class ChildrenStarted extends ChildrenEvent {
  const ChildrenStarted();
}

/// Pull-to-refresh on the linked children list.
final class ChildrenRefreshRequested extends ChildrenEvent {
  const ChildrenRefreshRequested();
}

/// Search-by-admission-code or phone — populates `state.lookupSection.data`.
final class ChildrenLookupRequested extends ChildrenEvent {
  final String query;
  const ChildrenLookupRequested(this.query);

  @override
  List<Object?> get props => [query];
}

/// Clears the result of a previous lookup (e.g. after editing the search box).
final class ChildrenLookupCleared extends ChildrenEvent {
  const ChildrenLookupCleared();
}

/// Commits the lookup + relationship choice and links the child to the
/// parent account.
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

/// Detaches the given child from the parent account.
final class ChildUnlinkRequested extends ChildrenEvent {
  final String childId;
  const ChildUnlinkRequested(this.childId);

  @override
  List<Object?> get props => [childId];
}
