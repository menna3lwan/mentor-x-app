part of 'top_up_bloc.dart';

enum TopUpStatus { idle, submitting, success, failure }

final class TopUpState extends Equatable {
  final String amountInput;
  final TopUpStatus status;

  const TopUpState({required this.amountInput, required this.status});

  factory TopUpState.initial() =>
      const TopUpState(amountInput: '', status: TopUpStatus.idle);

  bool get isSubmitting => status == TopUpStatus.submitting;

  TopUpState copyWith({String? amountInput, TopUpStatus? status}) {
    return TopUpState(
      amountInput: amountInput ?? this.amountInput,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [amountInput, status];
}
