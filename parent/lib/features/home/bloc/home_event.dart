part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// First entry to the home screen — loads children, picks an active child,
/// and pulls the dashboard for that child.
final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

/// Switches the currently active child and pulls a fresh dashboard for it.
final class HomeChildSwitched extends HomeEvent {
  final ParentChildEntity child;
  const HomeChildSwitched(this.child);

  @override
  List<Object?> get props => [child];
}

/// Pull-to-refresh — reloads the children list (so newly linked kids appear)
/// and the dashboard sections for the currently selected child.
final class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}

/// Per-section retry, used by inline error views.
final class HomeRetrySectionRequested extends HomeEvent {
  final HomeSection section;
  const HomeRetrySectionRequested(this.section);

  @override
  List<Object?> get props => [section];
}
