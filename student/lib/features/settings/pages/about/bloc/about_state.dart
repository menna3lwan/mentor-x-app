part of 'about_bloc.dart';

final class AboutState extends Equatable {
  final LoadingState loadingState;

  const AboutState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AboutState();

  @override
  List<Object?> get props => [loadingState];

  AboutState copyWith({LoadingState? loadingState}) {
    return AboutState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
