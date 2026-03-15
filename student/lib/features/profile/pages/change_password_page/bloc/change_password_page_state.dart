part of 'change_password_page_bloc.dart';

final class ChangePasswordPageState extends Equatable {
  final LoadingState loadingState;

  const ChangePasswordPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ChangePasswordPageState();

  @override
  List<Object?> get props => [loadingState];

  ChangePasswordPageState copyWith({LoadingState? loadingState}) {
    return ChangePasswordPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
