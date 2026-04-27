part of 'redeem_code_page_bloc.dart';

final class RedeemCodePageState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const RedeemCodePageState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = RedeemCodePageState();

  @override
  List<Object?> get props => [loadingState, errorMessage];

  RedeemCodePageState copyWith({
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return RedeemCodePageState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
