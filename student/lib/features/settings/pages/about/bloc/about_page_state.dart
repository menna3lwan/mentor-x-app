part of 'about_page_bloc.dart';

final class AboutPageState extends Equatable {
  final LoadingState loadingState;

  const AboutPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AboutPageState();

  @override
  List<Object?> get props => [loadingState];

  AboutPageState copyWith({LoadingState? loadingState}) {
    return AboutPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
