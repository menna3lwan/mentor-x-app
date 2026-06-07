part of 'leaderboard_bloc.dart';

sealed class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

final class LeaderboardLoadRequested extends LeaderboardEvent {
  final String? courseId;
  const LeaderboardLoadRequested({this.courseId});

  @override
  List<Object?> get props => [courseId];
}

final class LeaderboardFilterChanged extends LeaderboardEvent {
  final String? courseId;
  const LeaderboardFilterChanged(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
