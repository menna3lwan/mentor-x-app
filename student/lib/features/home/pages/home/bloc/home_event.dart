part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeInitializedEvent extends HomeEvent {
  const HomeInitializedEvent();
}

final class HomeRefreshedEvent extends HomeEvent {
  const HomeRefreshedEvent();
}

final class HomeRetrySectionEvent extends HomeEvent {
  final HomeSection section;

  const HomeRetrySectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

final class HomeBannerClickedEvent extends HomeEvent {
  final String bannerId;

  const HomeBannerClickedEvent(this.bannerId);

  @override
  List<Object?> get props => [bannerId];
}
