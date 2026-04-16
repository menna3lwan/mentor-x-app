import 'package:dio_student_registration_repository/dio_student_registration_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioStudentRegistrationRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioStudentRegistrationRepository(httpClient: httpClient);
  });

  group('DioStudentRegistrationRepository', () {
    group('checkPhoneUniqueness', () {
      test('returns true when api indicates phone is unique', () async {
        when(
          () => httpClient.post(
            '/api/v1/auth/check-phone',
            data: {'phone': '01011111111'},
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {'is_unique': true},
            },
            statusCode: 200,
          ),
        );

        final result = await repository.checkPhoneUniqueness('01011111111');

        expect(result, isTrue);
      });

      test('returns false when api returns conflict status', () async {
        when(
          () => httpClient.post(
            '/api/v1/auth/check-phone',
            data: {'phone': '01000000000'},
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {'message': 'already exists'},
            statusCode: 409,
          ),
        );

        final result = await repository.checkPhoneUniqueness('01000000000');

        expect(result, isFalse);
      });

      test('returns false when payload contains exists=true', () async {
        when(
          () => httpClient.post(
            '/api/v1/auth/check-phone',
            data: {'phone': '01000000000'},
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {'exists': true},
            },
            statusCode: 200,
          ),
        );

        final result = await repository.checkPhoneUniqueness('01000000000');

        expect(result, isFalse);
      });

      test(
        'throws unknown exception for non-duplicate backend errors',
        () async {
          when(
            () => httpClient.post(
              '/api/v1/auth/check-phone',
              data: {'phone': '01011111111'},
            ),
          ).thenThrow(
            HttpClientResponse(
              data: {'message': 'server down'},
              statusCode: 500,
              exception: HttpClientException(
                code: HttpClientExceptionCode.serverError,
                message: 'server down',
              ),
            ),
          );

          expect(
            () => repository.checkPhoneUniqueness('01011111111'),
            throwsA(
              isA<StudentRegistrationException>().having(
                (e) => e.code,
                'code',
                StudentRegistrationExceptionCode.unknown,
              ),
            ),
          );
        },
      );
    });

    test('getGrades parses grade list from envelope', () async {
      when(
        () => httpClient.get('/api/v1/tenants/1/grades'),
      ).thenAnswer(
        (_) async => const HttpClientResponse(
          data: {
            'data': [
              {'id': 1, 'name': 'Grade 1'},
              {'id': 2, 'name': 'Grade 2'},
            ],
          },
          statusCode: 200,
        ),
      );

      final result = await repository.getGrades('1');

      expect(result, hasLength(2));
      expect(result.first.id, '1');
      expect(result.first.name, 'Grade 1');
    });

    test('getSchedules sends parsed int query parameter ids', () async {
      when(
        () => httpClient.get(
          '/api/v1/centers/10/schedules',
          queryParameters: {'grade_id': 3},
        ),
      ).thenAnswer(
        (_) async => const HttpClientResponse(
          data: {
            'data': [
              {
                'id': 7,
                'day': 'Saturday',
                'start_time': '10:00',
                'end_time': '12:00',
              },
            ],
          },
          statusCode: 200,
        ),
      );

      final result = await repository.getSchedules(
        centerId: '10',
        gradeId: '3',
      );

      expect(result, hasLength(1));
      expect(result.first.id, '7');
      verify(
        () => httpClient.get(
          '/api/v1/centers/10/schedules',
          queryParameters: {'grade_id': 3},
        ),
      ).called(1);
    });

    test(
      'getDistricts falls back to requested governorate id when missing',
      () async {
        when(
          () => httpClient.get('/api/v1/lookups/governorates/12/districts'),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': [
                {'id': 9, 'name': 'District A'},
              ],
            },
            statusCode: 200,
          ),
        );

        final result = await repository.getDistricts('12');

        expect(result, hasLength(1));
        expect(result.first.id, '9');
        expect(result.first.governorateId, '12');
      },
    );

    group('uploadImage', () {
      test('returns image url on first attempt', () async {
        when(
          () => httpClient.postMultipart(
            '/api/v1/upload/image',
            files: {
              'image': ['/tmp/photo.jpg'],
            },
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {'image_url': 'https://cdn.example.com/photo.jpg'},
            },
            statusCode: 200,
          ),
        );

        final result = await repository.uploadImage('/tmp/photo.jpg');

        expect(result, 'https://cdn.example.com/photo.jpg');
      });

      test('retries with file field when first attempt fails', () async {
        when(
          () => httpClient.postMultipart(
            '/api/v1/upload/image',
            files: {
              'image': ['/tmp/photo.jpg'],
            },
          ),
        ).thenThrow(
          HttpClientResponse(
            data: {'message': 'Invalid image field'},
            statusCode: 400,
            exception: HttpClientException(
              code: HttpClientExceptionCode.badResponse,
              message: 'Invalid image field',
            ),
          ),
        );

        when(
          () => httpClient.postMultipart(
            '/api/v1/upload/image',
            files: {
              'file': ['/tmp/photo.jpg'],
            },
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {'file_url': 'https://cdn.example.com/photo.jpg'},
            },
            statusCode: 200,
          ),
        );

        final result = await repository.uploadImage('/tmp/photo.jpg');

        expect(result, 'https://cdn.example.com/photo.jpg');
        verify(
          () => httpClient.postMultipart(
            '/api/v1/upload/image',
            files: {
              'image': ['/tmp/photo.jpg'],
            },
          ),
        ).called(1);
        verify(
          () => httpClient.postMultipart(
            '/api/v1/upload/image',
            files: {
              'file': ['/tmp/photo.jpg'],
            },
          ),
        ).called(1);
      });
    });

    group('register', () {
      test('returns student code and otp duration on success', () async {
        when(
          () => httpClient.post(
            '/api/v1/auth/register',
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {
                'student_code': 'MX-2026-0001',
                'otp_expires_in_seconds': 300,
              },
            },
            statusCode: 201,
          ),
        );

        final result = await repository.register(
          tenantId: '1',
          firstName: 'Ahmed',
          lastName: 'Ali',
          phone: '01011111111',
          gender: 'male',
          dateOfBirth: DateTime(2008, 3, 15),
          gradeId: '3',
          studyType: 'online',
          governorateId: '12',
          districtId: '45',
          parentName: 'Parent Name',
          parentPhone: '01022222222',
          password: 'Secure@Pass1',
          deviceHash: 'device-hash-123',
        );

        expect(result.studentCode, 'MX-2026-0001');
        expect(result.otpExpiresInSeconds, 300);

        final payload =
            verify(
                  () => httpClient.post(
                    '/api/v1/auth/register',
                    data: captureAny(named: 'data'),
                  ),
                ).captured.single
                as Map<String, dynamic>;
        expect(payload['tenant_id'], 1);
        expect(payload['grade_id'], 3);
        expect(payload['date_of_birth'], '2008-03-15');
      });

      test(
        'throws phoneAlreadyExists when backend reports duplicate phone',
        () async {
          when(
            () => httpClient.post(
              '/api/v1/auth/register',
              data: any(named: 'data'),
            ),
          ).thenThrow(
            HttpClientResponse(
              data: {'message': 'phone already exists'},
              statusCode: 409,
              exception: HttpClientException(
                code: HttpClientExceptionCode.badResponse,
                message: 'phone already exists',
              ),
            ),
          );

          expect(
            () => repository.register(
              tenantId: '1',
              firstName: 'Ahmed',
              lastName: 'Ali',
              phone: '01011111111',
              gender: 'male',
              dateOfBirth: DateTime(2008, 3, 15),
              gradeId: '3',
              studyType: 'online',
              governorateId: '12',
              districtId: '45',
              parentName: 'Parent Name',
              parentPhone: '01022222222',
              password: 'Secure@Pass1',
              deviceHash: 'device-hash-123',
            ),
            throwsA(
              isA<StudentRegistrationException>().having(
                (e) => e.code,
                'code',
                StudentRegistrationExceptionCode.phoneAlreadyExists,
              ),
            ),
          );
        },
      );
    });
  });
}
