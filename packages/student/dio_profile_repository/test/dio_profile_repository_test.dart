import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_profile_repository/dio_profile_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioStudentProfileRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioStudentProfileRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioStudentProfileRepository', () {
    group('getProfile', () {
      test('returns StudentEntity on success', () async {
        final mockData = {
          'id': 'p1',
          'first_name': 'Test',
          'last_name': 'User',
          'phone': '123456',
        };

        when(() => httpClient.get(
          '/api/student/profile',
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getProfile();
        expect(result.id, 'p1');
        expect(result.firstName, 'Test');
      });
    });

    group('getDevices', () {
      test('returns list of DeviceEntity on success', () async {
        final mockData = {
          'content': [
            {
              'id': 'd1',
              'device_name': 'iPhone',
              'last_used_at': DateTime.now().toIso8601String(),
            }
          ]
        };

        when(() => httpClient.get(
          '/api/auth/session-status',
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getDevices();
        expect(result.length, 1);
        expect(result[0].deviceName, 'iPhone');
      });

      test('returns representative device on slim session-status response', () async {
        final mockData = {
          'role': 'STUDENT',
          'studentCode': 'G2766',
          'hasSession': true,
          'status': 'ACTIVE',
        };

        when(() => httpClient.get(
          '/api/auth/session-status',
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getDevices();
        expect(result.length, 1);
        expect(result[0].id, 'G2766');
        expect(result[0].deviceName, 'Active Session');
      });
    });

    group('submitEditRequest', () {
      test('returns ProfileEditRequestEntity on success', () async {
        final mockData = {
          'id': 'req1',
          'field_name': 'firstName',
          'old_value': 'Old Name',
          'new_value': 'New Name',
          'status': 'pending',
          'created_at': DateTime.now().toIso8601String(),
        };

        when(() => httpClient.post(
          '/api/student/profile/edit-requests',
          data: any(named: 'data'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.submitEditRequest(
          fieldName: 'firstName',
          oldValue: 'Old Name',
          newValue: 'New Name',
        );
        expect(result.id, 'req1');
        expect(result.fieldName, 'firstName');
      });
    });
  });
}
