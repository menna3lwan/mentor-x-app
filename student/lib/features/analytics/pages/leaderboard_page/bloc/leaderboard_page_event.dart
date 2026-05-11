part of 'leaderboard_page_bloc.dart';

sealed class LeaderboardPageEvent extends Equatable {
  const LeaderboardPageEvent();

  @override
  List<Object?> get props => [];
}

final class LeaderboardPageLoadRequested extends LeaderboardPageEvent {
  final String? courseId;
  const LeaderboardPageLoadRequested({this.courseId});

  @override
  List<Object?> get props => [courseId];
}

final class LeaderboardPageFilterChanged extends LeaderboardPageEvent {
  final String? courseId;
  const LeaderboardPageFilterChanged(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
