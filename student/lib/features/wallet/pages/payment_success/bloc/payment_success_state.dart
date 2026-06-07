part of 'payment_success_bloc.dart';

final class PaymentSuccessState extends Equatable {
  final LoadingState loadingState;

  const PaymentSuccessState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = PaymentSuccessState();

  @override
  List<Object?> get props => [loadingState];

  PaymentSuccessState copyWith({LoadingState? loadingState}) {
    return PaymentSuccessState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
