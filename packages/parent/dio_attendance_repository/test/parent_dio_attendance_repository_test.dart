import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:parent_dio_attendance_repository/parent_dio_attendance_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioParentAttendanceRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioParentAttendanceRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioParentAttendanceRepository', () {
    test('getGroupBrief calls correct endpoint', () async {
      when(() => httpClient.get(
        any(),
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer((_) async => HttpClientResponse(
        data: {'id': 'g1', 'name': 'Brief'},
        statusCode: 200,
      ));

      final result = await repository.getGroupBrief('c1', 'g1');
      expect(result['id'], 'g1');
    });
  });
}
