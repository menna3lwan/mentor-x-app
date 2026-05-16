import 'package:mentorx_core/mentorx_core.dart';
import 'models/rewards_models.dart';
export 'models/rewards_models.dart';

final class DioRewardsRepository
    extends HttpClientRepository<RewardsRepositoryExceptionCode>
    implements RewardsRepository {
  @override
  Never throwException(
    RewardsRepositoryExceptionCode code, {
    String? message,
  }) => throw RewardsRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioRewardsRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<PointsTransactionEntity>> getPointsHistory({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/student/points/history',
        queryParameters: queryParams,
      );

      final list = response.asList();
      return list
          .map((e) => PointsTransactionModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToLoadPointsHistory,
      );
    }
  }

  @override
  Future<List<RewardItemEntity>> getRewardItems({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/rewards/items',
        queryParameters: queryParams,
      );

      final list = response.asList();
      return list.map((e) => RewardItemModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToLoadRewardItems,
      );
    }
  }

  @override
  Future<List<RewardClaimEntity>> getRewardClaims({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/rewards/claims',
        queryParameters: queryParams,
      );

      final list = response.asList();
      return list.map((e) => RewardClaimModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToLoadClaims,
      );
    }
  }

  @override
  Future<RewardClaimEntity> claimReward(String rewardItemId) async {
    try {
      final payload = {'reward_item_id': rewardItemId};
      final response = await httpClient.post(
        '/api/rewards/claims',
        data: payload,
      );

      return RewardClaimModel.fromJson(response.asMap());
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: RewardsRepositoryExceptionCode.failedToClaimReward,
      );
    }
  }
}
