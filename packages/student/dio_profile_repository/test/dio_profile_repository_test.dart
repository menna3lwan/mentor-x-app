import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_profile_repository/dio_profile_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioStudentProfileRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioStudentProfileRepository(httpClient: mockHttpClient);
  });

  group('DioStudentProfileRepository', () {
    test('getVerificationStatus returns verification status on success', () async {
      final mockResponse = {
        'data': {
          'status': 'pending',
          'id_card_photo_url': 'https://example.com/id.jpg',
          'verified_at': null,
          'rejection_reason': null,
        }
      };

      when(() => mockHttpClient.get('/api/student/profile/verification-status'))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getVerificationStatus();

      expect(result.status, VerificationStatus.pending);
      expect(result.idCardPhotoUrl, 'https://example.com/id.jpg');
    });

    test('getProfile returns student entity on success', () async {
      final mockResponse = {
        'data': {
          'id': '1',
          'name': 'Test Student',
          'phone': '123456789',
          'email': 'test@example.com',
          'status': 'active',
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.get('/api/student/profile'))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getProfile();

      expect(result.id, '1');
      expect(result.name, 'Test Student');
    });

    test('getDevices returns list of devices', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'd1',
            'deviceName': 'iPhone 13',
            'deviceModel': 'A2633',
            'isActive': true,
            'lastUsedAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get('/api/student/profile/devices'))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getDevices();

      expect(result.length, 1);
      expect(result.first.deviceName, 'iPhone 13');
    });

    test('deactivateDevice calls delete and returns normally', () async {
      when(() => mockHttpClient.delete('/api/student/profile/devices/d1'))
          .thenAnswer((_) async => HttpClientResponse(
                data: {},
                statusCode: 200,
              ));

      await repository.deactivateDevice('d1');

      verify(() => mockHttpClient.delete('/api/student/profile/devices/d1')).called(1);
    });
  });
}
