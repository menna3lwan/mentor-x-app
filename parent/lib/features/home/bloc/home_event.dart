part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeChildSwitched extends HomeEvent {
  final ParentChildEntity child;
  const HomeChildSwitched(this.child);

  @override
  List<Object?> get props => [child];
}

class HomeRefreshRequested extends HomeEvent {}
