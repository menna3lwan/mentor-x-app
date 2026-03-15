part of 'support_page_bloc.dart';

final class SupportPageState extends Equatable {
  final LoadingState loadingState;

  const SupportPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = SupportPageState();

  @override
  List<Object?> get props => [loadingState];

  SupportPageState copyWith({LoadingState? loadingState}) {
    return SupportPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
