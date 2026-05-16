import 'package:mentorx_core/mentorx_core.dart';
import 'src/models/student_card_model.dart';

final class DioStudentCardRepository
    extends HttpClientRepository<StudentCardRepositoryExceptionCode>
    implements StudentCardRepository {
  @override
  Never throwException(
    StudentCardRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw StudentCardRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioStudentCardRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<StudentCardEntity> getMyCard() async {
    try {
      final response = await httpClient.get('/api/cards/my');
      final data = response.asMap();
      return StudentCardModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentCardRepositoryExceptionCode.failedToLoadCard,
      );
    }
  }

  @override
  Future<StudentCardEntity> validateQr(String qrToken) async {
    try {
      final response = await httpClient.get('/api/cards/validate/$qrToken');
      final data = response.asMap();
      return StudentCardModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: StudentCardRepositoryExceptionCode.failedToLoadCard,
      );
    }
  }
}
