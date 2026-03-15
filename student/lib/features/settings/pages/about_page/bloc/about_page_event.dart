part of 'about_page_bloc.dart';

sealed class AboutPageEvent extends Equatable {
  const AboutPageEvent();

  @override
  List<Object?> get props => [];
}

final class AboutPageLoadEvent extends AboutPageEvent {
  const AboutPageLoadEvent();
}
