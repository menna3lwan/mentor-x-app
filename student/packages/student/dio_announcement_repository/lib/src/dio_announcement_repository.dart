import 'package:mentorx_core/mentorx_core.dart';
import '../models/announcement_model.dart';

final class DioAnnouncementRepository
    extends HttpClientRepository<AnnouncementRepositoryExceptionCode>
    implements AnnouncementRepository {
  @override
  Never throwException(AnnouncementRepositoryExceptionCode code,
          {String? message}) =>
      throw AnnouncementRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioAnnouncementRepository({required this.httpClient});

  @override
  Future<List<AnnouncementEntity>> getAnnouncements({
    String? search,
    bool? pinned,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/announcements',
      queryParameters: {
        if (search != null) 'search': search,
        if (pinned != null) 'pinned': pinned,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != 200) {
      throw AnnouncementRepositoryException(
        code: AnnouncementRepositoryExceptionCode.failedToLoadAnnouncements,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AnnouncementModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<AnnouncementEntity> getAnnouncementDetail(String announcementId) async {
    final response = await httpClient.get('/api/announcements/$announcementId');

    if (response.statusCode != 200) {
      throw AnnouncementRepositoryException(
        code: AnnouncementRepositoryExceptionCode.failedToLoadAnnouncementDetail,
        message: response.exception?.message,
      );
    }

    return AnnouncementModel.fromJson(response.data['data'] ?? response.data);
  }
}
