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
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/leaderboard/global',
        queryParameters: queryParams,
      );

      final dataMap = asMap(response.data)['data'] ?? asMap(response.data);
      final entriesList = asList(dataMap['entries'] ?? dataMap['content'] ?? dataMap);
      
      return entriesList.map((e) => LeaderboardEntryModel.fromJson(asMap(e))).toList();
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
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/leaderboard/course/$courseId',
        queryParameters: queryParams,
      );

      final dataMap = asMap(response.data)['data'] ?? asMap(response.data);
      final entriesList = asList(dataMap['entries'] ?? dataMap['content'] ?? dataMap);

      return entriesList.map((e) => LeaderboardEntryModel.fromJson(asMap(e))).toList();
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
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/leaderboard/quiz/$quizId',
        queryParameters: queryParams,
      );

      final dataMap = ModelParser.extractData(response.data);
      final entriesList = ModelParser.asList(dataMap);

      return entriesList.map((e) => LeaderboardEntryModel.fromJson(asMap(e))).toList();
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
