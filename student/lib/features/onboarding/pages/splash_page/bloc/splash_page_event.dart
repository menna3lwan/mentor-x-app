part of 'splash_page_bloc.dart';

sealed class SplashPageEvent extends Equatable {
  const SplashPageEvent();

  @override
  List<Object?> get props => [];
}

final class SplashPageStarted extends SplashPageEvent {
  const SplashPageStarted();
}
