import 'package:mentorx_core/mentorx_core.dart';

typedef _Exception = StudentRegistrationException;
typedef _ExceptionCode = StudentRegistrationExceptionCode;

final class DioStudentRegistrationRepository
    extends HttpClientRepository<StudentRegistrationExceptionCode>
    implements StudentRegistrationRepository {
  @override
  Never throwException(
    StudentRegistrationExceptionCode code, {
    String? message,
  }) => throw _Exception(code: code, message: message);

  final HttpClient httpClient;

  DioStudentRegistrationRepository({required this.httpClient});

  @override
  Future<bool> checkPhoneUniqueness(String phone) async {
    try {
      final response = await httpClient.post(
        '/api/v1/auth/check-phone',
        data: {'phone': phone},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final isUnique = boolOrNull(
        data['is_unique'] ??
            data['isUnique'] ??
            data['unique'] ??
            data['available'],
      );
      if (isUnique != null) return isUnique;

      final exists = boolOrNull(
        data['exists'] ?? data['already_exists'] ?? data['alreadyExists'],
      );
      if (exists != null) return !exists;

      return true;
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 409 || _isDuplicatePhoneError(e)) {
        return false;
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<GradeEntity>> getGrades(String tenantId) async {
    try {
      final response = await httpClient.get('/api/v1/tenants/$tenantId/grades');
      final data = asList(response.data);
      return data.map((item) {
        final map = asMap(item);
        return GradeEntity(
          id: stringOrEmpty(map['id'] ?? map['grade_id']),
          name: stringOrEmpty(map['name'] ?? map['grade_name']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadGrades,
      );
    }
  }

  @override
  Future<List<CenterEntity>> getCenters(String tenantId) async {
    try {
      final response = await httpClient.get('/api/v1/tenants/$tenantId/centers');
      final data = asList(response.data);
      return data.map((item) {
        final map = asMap(item);
        return CenterEntity(
          id: stringOrEmpty(map['id'] ?? map['center_id']),
          name: stringOrEmpty(map['name'] ?? map['center_name']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadCenters,
      );
    }
  }

  @override
  Future<List<ScheduleEntity>> getSchedules({
    required String centerId,
    required String gradeId,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/v1/centers/$centerId/schedules',
        queryParameters: {
          'grade_id': _toApiId(gradeId),
        },
      );
      final data = asList(response.data);
      return data.map((item) {
        final map = asMap(item);
        return ScheduleEntity(
          id: stringOrEmpty(map['id'] ?? map['schedule_id']),
          day: stringOrEmpty(map['day'] ?? map['day_name']),
          startTime: stringOrEmpty(map['start_time'] ?? map['startTime'] ?? map['from_time']),
          endTime: stringOrEmpty(map['end_time'] ?? map['endTime'] ?? map['to_time']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadSchedules,
      );
    }
  }

  @override
  Future<List<GroupEntity>> getGroups({
    required String centerId,
    required String gradeId,
    required String scheduleId,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/v1/centers/$centerId/groups',
        queryParameters: {
          'grade_id': _toApiId(gradeId),
          'schedule_id': _toApiId(scheduleId),
        },
      );
      final data = asList(response.data);
      return data.map((item) {
        final map = asMap(item);
        return GroupEntity(
          id: stringOrEmpty(map['id'] ?? map['group_id']),
          name: stringOrEmpty(map['name'] ?? map['group_name']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadGroups,
      );
    }
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() async {
    try {
      final response = await httpClient.get('/api/v1/lookups/governorates');
      final data = asList(response.data);
      return data.map((item) {
        final map = asMap(item);
        return GovernorateEntity(
          id: stringOrEmpty(map['id'] ?? map['governorate_id']),
          name: stringOrEmpty(map['name'] ?? map['governorate_name']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadGovernorates,
      );
    }
  }

  @override
  Future<List<DistrictEntity>> getDistricts(String governorateId) async {
    try {
      final response = await httpClient.get(
        '/api/v1/lookups/governorates/$governorateId/districts',
      );
      final data = asList(response.data);
      return data.map((item) {
        final map = asMap(item);
        return DistrictEntity(
          id: stringOrEmpty(map['id'] ?? map['district_id']),
          name: stringOrEmpty(map['name'] ?? map['district_name']),
          governorateId: stringOrEmpty(map['governorate_id'] ?? map['governorateId'] ?? governorateId),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadDistricts,
      );
    }
  }

  @override
  Future<String> uploadImage(String filePath) async {
    try {
      final response = await httpClient.postMultipart(
        '/api/v1/upload/image',
        files: {
          'image': [filePath],
        },
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final url = stringOrEmpty(
        data['url'] ??
            data['image_url'] ??
            data['imageUrl'] ??
            data['file_url'] ??
            data['fileUrl'] ??
            data['path'],
      );
      if (url.isEmpty) {
        throw _Exception(
          code: _ExceptionCode.failedToUploadImage,
          message: 'Image upload did not return a valid URL.',
        );
      }
      return url;
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToUploadImage,
      );
    }
  }

  @override
  Future<({String studentCode, int? otpExpiresInSeconds})> register({
    required String tenantId,
    required String firstName,
    required String lastName,
    required String phone,
    String? email,
    required String gender,
    required DateTime dateOfBirth,
    String? profilePhotoUrl,
    required String gradeId,
    String? schoolName,
    required String studyType,
    String? centerId,
    String? scheduleId,
    String? centerGroupId,
    required String governorateId,
    required String districtId,
    required String parentName,
    required String parentPhone,
    required String password,
    String? idCardPhotoUrl,
    required String deviceHash,
  }) async {
    final rateLimitResult = AuthRateLimiter.canAttempt(phone, 'register');
    if (!rateLimitResult.canAttempt) {
      throw RateLimitExceededException(
        message: 'Too many registration attempts. Please wait.',
        remainingCooldown: rateLimitResult.remainingCooldown,
        identifier: phone,
        endpoint: 'register',
      );
    }

    try {
      final payload = <String, dynamic>{
        'tenant_id': _toApiId(tenantId),
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'gender': gender,
        'date_of_birth': _formatDate(dateOfBirth),
        'grade_id': _toApiId(gradeId),
        'study_type': studyType,
        'governorate_id': _toApiId(governorateId),
        'district_id': _toApiId(districtId),
        'parent_name': parentName,
        'parent_phone': parentPhone,
        'password': password,
        'device_hash': deviceHash,
        if (email != null && email.isNotEmpty) 'email': email,
        if (profilePhotoUrl != null && profilePhotoUrl.isNotEmpty)
          'profile_photo_url': profilePhotoUrl,
        if (schoolName != null && schoolName.isNotEmpty)
          'school_name': schoolName,
        if (centerId != null && centerId.isNotEmpty)
          'center_id': _toApiId(centerId),
        if (scheduleId != null && scheduleId.isNotEmpty)
          'schedule_id': _toApiId(scheduleId),
        if (centerGroupId != null && centerGroupId.isNotEmpty)
          'center_group_id': _toApiId(centerGroupId),
        if (idCardPhotoUrl != null && idCardPhotoUrl.isNotEmpty)
          'id_card_photo_url': idCardPhotoUrl,
      };

      final response = await httpClient.post(
        '/api/v1/auth/register',
        data: payload,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final studentCode = stringOrEmpty(
        data['student_code'] ?? data['studentCode'] ?? data['code'],
      );
      if (studentCode.isEmpty) {
        throw _Exception(
          code: _ExceptionCode.failedToRegister,
          message: 'Registration response did not include student code.',
        );
      }

      final otpExpiresInSeconds = intOrNull(
        data['otp_expires_in_seconds'] ?? data['otpExpiresInSeconds'],
      );

      return (
        studentCode: studentCode,
        otpExpiresInSeconds: otpExpiresInSeconds,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToRegister,
        codeFromStatusCode: (status) => status == 409 || _isDuplicatePhoneError(e)
            ? _ExceptionCode.phoneAlreadyExists
            : _ExceptionCode.failedToRegister,
      );
    }
  }

  bool _isDuplicatePhoneError(HttpClientResponse response) {
    final message = httpClient.extractErrorMessage(response)?.toLowerCase().trim() ?? '';
    if (message.isEmpty) return false;
    final mentionsPhone = message.contains('phone') || message.contains('mobile');
    final mentionsConflict = message.contains('exist') ||
        message.contains('taken') ||
        message.contains('used') ||
        message.contains('registered') ||
        message.contains('duplicate');
    return mentionsPhone && mentionsConflict;
  }

  static dynamic _toApiId(String value) {
    final parsedInt = int.tryParse(value);
    if (parsedInt != null) return parsedInt;
    return value;
  }

  static String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

}
