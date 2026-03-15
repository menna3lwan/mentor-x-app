part of 'redeem_code_page_bloc.dart';

final class RedeemCodePageState extends Equatable {
  final LoadingState loadingState;

  const RedeemCodePageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = RedeemCodePageState();

  @override
  List<Object?> get props => [loadingState];

  RedeemCodePageState copyWith({LoadingState? loadingState}) {
    return RedeemCodePageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
