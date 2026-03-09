part of 'walkthrough_page_bloc.dart';

enum WalkthroughPageStatus { initial, submitting, completed, failure }

final class WalkthroughPageState extends Equatable {
  final WalkthroughPageStatus status;

  const WalkthroughPageState({
    this.status = WalkthroughPageStatus.initial,
  });

  bool get isSubmitting => status == WalkthroughPageStatus.submitting;

  WalkthroughPageState copyWith({
    WalkthroughPageStatus? status,
  }) {
    return WalkthroughPageState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
