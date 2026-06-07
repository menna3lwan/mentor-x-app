part of 'redeem_code_bloc.dart';

final class RedeemCodeState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const RedeemCodeState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = RedeemCodeState();

  @override
  List<Object?> get props => [loadingState, errorMessage];

  RedeemCodeState copyWith({
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return RedeemCodeState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
