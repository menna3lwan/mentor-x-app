import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_attendance_repository/dio_attendance_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioAttendanceRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioAttendanceRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioAttendanceRepository', () {
    group('getRecords', () {
      test('returns list of AttendanceRecordEntity on success', () async {
        final mockData = {
          'content': [
            {
              'id': 'rec1',
              'session_id': 's1',
              'status': 'present',
              'recorded_at': DateTime.now().toIso8601String(),
            }
          ]
        };

        when(() => httpClient.get(
          '/api/attendance/my',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getRecords();
        expect(result.length, 1);
        expect(result[0].id, 'rec1');
      });
    });

    group('checkIn', () {
      test('returns AttendanceRecordEntity on success', () async {
        final mockData = {
          'id': 'rec2',
          'status': 'present',
        };

        when(() => httpClient.post(
          '/api/attendance/check-in',
          data: any(named: 'data'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.checkIn('qr-data');
        expect(result.id, 'rec2');
      });
    });
  });
}
