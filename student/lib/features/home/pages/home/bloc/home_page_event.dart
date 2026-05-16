part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

final class HomePageInitializedEvent extends HomePageEvent {
  const HomePageInitializedEvent();
}

final class HomePageRefreshedEvent extends HomePageEvent {
  const HomePageRefreshedEvent();
}

final class HomePageRetrySectionEvent extends HomePageEvent {
  final HomeSection section;

  const HomePageRetrySectionEvent(this.section);

  @override
  List<Object?> get props => [section];
}

final class HomePageBannerClickedEvent extends HomePageEvent {
  final String bannerId;

  const HomePageBannerClickedEvent(this.bannerId);

  @override
  List<Object?> get props => [bannerId];
}
