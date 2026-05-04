import 'package:mentorx_core/mentorx_core.dart';

final class MockLeaderboardRepository implements LeaderboardRepository {
  final Duration delay;

  MockLeaderboardRepository({this.delay = const Duration(milliseconds: 500)});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<LeaderboardEntryEntity>> getGlobalLeaderboard({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future.delayed(delay);
    return _mockEntries();
  }

  @override
  Future<List<LeaderboardEntryEntity>> getCourseLeaderboard(
    String courseId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future.delayed(delay);
    return _mockEntries();
  }

  @override
  Future<List<LeaderboardEntryEntity>> getQuizLeaderboard(
    String quizId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future.delayed(delay);
    return _mockEntries();
  }

  @override
  Future<LeaderboardEntryEntity> getMyQuizRank(String quizId) async {
    await Future.delayed(delay);
    return _mockEntries()[2].copyWith(isCurrentUser: true);
  }

  List<LeaderboardEntryEntity> _mockEntries() {
    return [
      const LeaderboardEntryEntity(
        rank: 1,
        studentId: '1',
        studentName: 'محمد علي',
        points: 3200,
        score: 98,
        quizCount: 22,
      ),
      const LeaderboardEntryEntity(
        rank: 2,
        studentId: '2',
        studentName: 'سارة أحمد',
        points: 2900,
        score: 95,
        quizCount: 20,
      ),
      const LeaderboardEntryEntity(
        rank: 3,
        studentId: '3',
        studentName: 'أحمد محمد',
        points: 2450,
        score: 90,
        quizCount: 18,
        isCurrentUser: true,
      ),
      const LeaderboardEntryEntity(
        rank: 4,
        studentId: '4',
        studentName: 'فاطمة حسن',
        points: 2100,
        score: 88,
        quizCount: 16,
      ),
      const LeaderboardEntryEntity(
        rank: 5,
        studentId: '5',
        studentName: 'عمر خالد',
        points: 1800,
        score: 85,
        quizCount: 15,
      ),
    ];
  }
}
