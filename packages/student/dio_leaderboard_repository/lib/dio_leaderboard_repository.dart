import 'package:mentorx_core/mentorx_core.dart';
import 'models/leaderboard_models.dart';
export 'models/leaderboard_models.dart';

final class DioLeaderboardRepository
    extends HttpClientRepository<LeaderboardRepositoryExceptionCode>
    implements LeaderboardRepository {
  @override
  Never throwException(
    LeaderboardRepositoryExceptionCode code, {
    String? message,
  }) => throw LeaderboardRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioLeaderboardRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<LeaderboardEntryEntity>> getGlobalLeaderboard({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/leaderboard/global',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data.map((e) => LeaderboardEntryModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: LeaderboardRepositoryExceptionCode.failedToLoadLeaderboard,
      );
    }
  }

  @override
  Future<List<LeaderboardEntryEntity>> getCourseLeaderboard(
    String courseId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/leaderboard/course/$courseId',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data.map((e) => LeaderboardEntryModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: LeaderboardRepositoryExceptionCode.failedToLoadLeaderboard,
      );
    }
  }

  @override
  Future<List<LeaderboardEntryEntity>> getQuizLeaderboard(
    String quizId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/leaderboard/quiz/$quizId',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final data = asList(asMap(response.data)['data'] ??
          asMap(response.data)['content'] ??
          response.data);
      return data.map((e) => LeaderboardEntryModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: LeaderboardRepositoryExceptionCode.failedToLoadLeaderboard,
      );
    }
  }

  @override
  Future<LeaderboardEntryEntity> getMyQuizRank(String quizId) async {
    try {
      final response = await httpClient.get(
        '/api/leaderboard/quiz/$quizId/my-rank',
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return LeaderboardEntryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: LeaderboardRepositoryExceptionCode.failedToLoadMyRank,
      );
    }
  }
}
