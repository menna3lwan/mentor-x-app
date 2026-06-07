part of 'about_bloc.dart';

sealed class AboutEvent extends Equatable {
  const AboutEvent();

  @override
  List<Object?> get props => [];
}

final class AboutLoadEvent extends AboutEvent {
  const AboutLoadEvent();
}
