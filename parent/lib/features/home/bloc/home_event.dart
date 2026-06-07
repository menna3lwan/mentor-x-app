part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeStarted extends HomeEvent {}

final class HomeChildSwitched extends HomeEvent {
  final ParentChildEntity child;
  const HomeChildSwitched(this.child);

  @override
  List<Object?> get props => [child];
}

final class HomeRefreshRequested extends HomeEvent {}
