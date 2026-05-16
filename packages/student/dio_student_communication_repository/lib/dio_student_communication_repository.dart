import 'package:mentorx_core/mentorx_core.dart';
import 'models/communication_models.dart';

export 'models/communication_models.dart';

final class DioStudentCommunicationRepository
    extends HttpClientRepository<StudentCommunicationRepositoryExceptionCode>
    implements StudentCommunicationRepository {
  final HttpClient httpClient;

  DioStudentCommunicationRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    StudentCommunicationRepositoryExceptionCode code, {
    String? message,
  }) {
    throw StudentCommunicationRepositoryException(code: code, message: message);
  }

  @override
  Future<List<WhatsAppGroupEntity>> getWhatsAppGroups() async {
    try {
      final response = await httpClient.get('/api/student/whatsapp-groups');
      final list = response.asList();
      return list.map((e) => WhatsAppGroupModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentCommunicationRepositoryExceptionCode
            .failedToLoadWhatsAppGroups,
      );
    }
  }
}
