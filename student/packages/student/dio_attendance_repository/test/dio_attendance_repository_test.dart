import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_attendance_repository/src/dio_attendance_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioAttendanceRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioAttendanceRepository(httpClient: mockHttpClient);
  });

  group('DioAttendanceRepository', () {
    test('getSummary returns attendance summary', () async {
      final mockResponse = {
        'data': {
          'totalSessions': 10,
          'present': 8,
          'absent': 1,
          'late': 1,
          'excused': 0,
          'attendanceRate': 0.8,
        }
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getSummary();

      expect(result.totalSessions, 10);
      expect(result.present, 8);
    });

    test('getRecords returns list of records', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'r1',
            'status': 'present',
            'date': DateTime.now().toIso8601String(),
            'courseName': 'Math',
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getRecords();

      expect(result.length, 1);
      expect(result.first.courseName, 'Math');
    });

    test('checkIn returns record entity', () async {
      final mockResponse = {
        'data': {
          'id': 'r1',
          'status': 'present',
          'date': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.checkIn('quiz_qr_code');

      expect(result.id, 'r1');
      expect(result.status, AttendanceStatus.present);
    });
  });
}
