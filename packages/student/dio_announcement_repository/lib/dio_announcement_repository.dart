import 'package:mentorx_core/mentorx_core.dart';
import 'models/announcement_model.dart';
export 'models/announcement_model.dart';

final class DioAnnouncementRepository
    extends HttpClientRepository<AnnouncementRepositoryExceptionCode>
    implements AnnouncementRepository {
  @override
  Never throwException(
    AnnouncementRepositoryExceptionCode code, {
    String? message,
  }) => throw AnnouncementRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioAnnouncementRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<AnnouncementEntity>> getAnnouncements({
    String? search,
    bool? pinned,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (search != null) 'search': search,
        if (pinned != null) 'pinned': pinned,
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/announcements/active',
        queryParameters: queryParams,
      );

      final list = response.asList();
      return list.map((e) => AnnouncementModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            AnnouncementRepositoryExceptionCode.failedToLoadAnnouncements,
      );
    }
  }

  @override
  Future<AnnouncementEntity> getAnnouncementDetail(
    String announcementId,
  ) async {
    try {
      final response = await httpClient.get(
        '/api/announcements/$announcementId',
      );
      final data = response.asMap();
      return AnnouncementModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            AnnouncementRepositoryExceptionCode.failedToLoadAnnouncementDetail,
      );
    }
  }
}
