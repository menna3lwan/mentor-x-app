part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

final class SplashStarted extends SplashEvent {
  const SplashStarted();
}

final class SplashRetryRequested extends SplashEvent {
  const SplashRetryRequested();
}
