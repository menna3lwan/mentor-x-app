part of 'top_up_bloc.dart';

sealed class TopUpEvent extends Equatable {
  const TopUpEvent();

  @override
  List<Object?> get props => const [];
}

final class TopUpAmountChanged extends TopUpEvent {
  final String value;
  const TopUpAmountChanged(this.value);

  @override
  List<Object?> get props => [value];
}

final class TopUpPresetSelected extends TopUpEvent {
  final double amount;
  const TopUpPresetSelected(this.amount);

  @override
  List<Object?> get props => [amount];
}

final class TopUpSubmitted extends TopUpEvent {
  const TopUpSubmitted();
}
