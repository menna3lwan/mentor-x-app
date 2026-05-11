part of 'package:mentorx_core/mentorx_core.dart';

enum LeaderboardRepositoryExceptionCode {
  unknown,
  failedToLoadLeaderboard,
  failedToLoadMyRank,
}

final class LeaderboardRepositoryException
    extends MentorXException<LeaderboardRepositoryExceptionCode> {
  const LeaderboardRepositoryException({required super.code, super.message});
}

abstract interface class LeaderboardRepository {
  Future<void> initialize();

  /// Fetch global leaderboard.
  Future<List<LeaderboardEntryEntity>> getGlobalLeaderboard({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch leaderboard for a specific course.
  Future<List<LeaderboardEntryEntity>> getCourseLeaderboard(
    String courseId, {
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch leaderboard for a specific quiz.
  Future<List<LeaderboardEntryEntity>> getQuizLeaderboard(
    String quizId, {
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch current student's rank in a specific quiz.
  Future<LeaderboardEntryEntity> getMyQuizRank(String quizId);
}
