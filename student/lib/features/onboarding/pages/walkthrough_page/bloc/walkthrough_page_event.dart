part of 'walkthrough_page_bloc.dart';

sealed class WalkthroughPageEvent extends Equatable {
  const WalkthroughPageEvent();

  @override
  List<Object?> get props => [];
}

final class WalkthroughPageSkipped extends WalkthroughPageEvent {
  const WalkthroughPageSkipped();
}

final class WalkthroughPageCompleted extends WalkthroughPageEvent {
  const WalkthroughPageCompleted();
}
