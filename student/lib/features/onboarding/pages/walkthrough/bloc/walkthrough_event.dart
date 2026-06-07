part of 'walkthrough_bloc.dart';

sealed class WalkthroughEvent extends Equatable {
  const WalkthroughEvent();

  @override
  List<Object?> get props => [];
}

final class WalkthroughSkipped extends WalkthroughEvent {
  const WalkthroughSkipped();
}

final class WalkthroughCompleted extends WalkthroughEvent {
  const WalkthroughCompleted();
}
