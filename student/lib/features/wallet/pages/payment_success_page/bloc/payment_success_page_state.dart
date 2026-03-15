part of 'payment_success_page_bloc.dart';

final class PaymentSuccessPageState extends Equatable {
  final LoadingState loadingState;

  const PaymentSuccessPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = PaymentSuccessPageState();

  @override
  List<Object?> get props => [loadingState];

  PaymentSuccessPageState copyWith({LoadingState? loadingState}) {
    return PaymentSuccessPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
