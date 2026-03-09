part of 'splash_page_bloc.dart';

enum SplashPageStatus { loading, authenticated, unauthenticated, onboarding }

final class SplashPageState extends Equatable {
  final SplashPageStatus status;
  final StudentEntity? user;

  const SplashPageState({
    this.status = SplashPageStatus.loading,
    this.user,
  });

  SplashPageState copyWith({
    SplashPageStatus? status,
    StudentEntity? user,
  }) {
    return SplashPageState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
