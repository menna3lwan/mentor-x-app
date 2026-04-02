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
    final defaultException = _ExceptionCode.unknown;
    try {
      final response = await httpClient.post(
        '/api/v1/auth/check-phone',
        data: {'phone': phone},
      );

      if (response.statusCode == 409) return false;
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final data = _extractDataMap(response.data);
      final isUnique = _boolOrNull(
        data['is_unique'] ??
            data['isUnique'] ??
            data['unique'] ??
            data['available'],
      );
      if (isUnique != null) return isUnique;

      final exists = _boolOrNull(
        data['exists'] ?? data['already_exists'] ?? data['alreadyExists'],
      );
      if (exists != null) return !exists;

      return true;
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 409 ||
          _isDuplicatePhoneError(errorResponse)) {
        return false;
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<List<GradeEntity>> getGrades(String tenantId) async {
    final defaultException = _ExceptionCode.failedToLoadGrades;
    try {
      final response = await httpClient.get('/api/v1/tenants/$tenantId/grades');
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final results = <GradeEntity>[];
      for (final item in _extractDataList(response.data)) {
        final map = _asMap(item);
        final id = _string(map['id'] ?? map['grade_id']);
        final name = _string(map['name'] ?? map['grade_name']);
        if (id.isEmpty || name.isEmpty) continue;
        results.add(GradeEntity(id: id, name: name));
      }
      return results;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<List<CenterEntity>> getCenters(String tenantId) async {
    final defaultException = _ExceptionCode.failedToLoadCenters;
    try {
      final response = await httpClient.get(
        '/api/v1/tenants/$tenantId/centers',
      );
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final results = <CenterEntity>[];
      for (final item in _extractDataList(response.data)) {
        final map = _asMap(item);
        final id = _string(map['id'] ?? map['center_id']);
        final name = _string(map['name'] ?? map['center_name']);
        if (id.isEmpty || name.isEmpty) continue;
        results.add(
          CenterEntity(
            id: id,
            name: name,
            address: _stringOrNull(map['address'] ?? map['location']),
          ),
        );
      }
      return results;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<List<ScheduleEntity>> getSchedules({
    required String centerId,
    required String gradeId,
  }) async {
    final defaultException = _ExceptionCode.failedToLoadSchedules;
    try {
      final response = await httpClient.get(
        '/api/v1/centers/$centerId/schedules',
        queryParameters: {
          'grade_id': _toApiId(gradeId),
        },
      );
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final results = <ScheduleEntity>[];
      for (final item in _extractDataList(response.data)) {
        final map = _asMap(item);
        final id = _string(map['id'] ?? map['schedule_id']);
        final day = _string(map['day'] ?? map['day_name']);
        final startTime = _string(
          map['start_time'] ?? map['startTime'] ?? map['from_time'],
        );
        final endTime = _string(
          map['end_time'] ?? map['endTime'] ?? map['to_time'],
        );
        if (id.isEmpty || day.isEmpty || startTime.isEmpty || endTime.isEmpty) {
          continue;
        }
        results.add(
          ScheduleEntity(
            id: id,
            day: day,
            startTime: startTime,
            endTime: endTime,
          ),
        );
      }
      return results;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<List<GroupEntity>> getGroups({
    required String centerId,
    required String gradeId,
    required String scheduleId,
  }) async {
    final defaultException = _ExceptionCode.failedToLoadGroups;
    try {
      final response = await httpClient.get(
        '/api/v1/centers/$centerId/groups',
        queryParameters: {
          'grade_id': _toApiId(gradeId),
          'schedule_id': _toApiId(scheduleId),
        },
      );
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final results = <GroupEntity>[];
      for (final item in _extractDataList(response.data)) {
        final map = _asMap(item);
        final id = _string(map['id'] ?? map['group_id']);
        final name = _string(map['name'] ?? map['group_name']);
        if (id.isEmpty || name.isEmpty) continue;
        results.add(
          GroupEntity(
            id: id,
            name: name,
            currentSize: _intOrNull(map['current_size'] ?? map['currentSize']),
            maxSize: _intOrNull(map['max_size'] ?? map['maxSize']),
          ),
        );
      }
      return results;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() async {
    final defaultException = _ExceptionCode.failedToLoadGovernorates;
    try {
      final response = await httpClient.get('/api/v1/lookups/governorates');
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final results = <GovernorateEntity>[];
      for (final item in _extractDataList(response.data)) {
        final map = _asMap(item);
        final id = _string(map['id'] ?? map['governorate_id']);
        final name = _string(map['name'] ?? map['governorate_name']);
        if (id.isEmpty || name.isEmpty) continue;
        results.add(GovernorateEntity(id: id, name: name));
      }
      return results;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<List<DistrictEntity>> getDistricts(String governorateId) async {
    final defaultException = _ExceptionCode.failedToLoadDistricts;
    try {
      final response = await httpClient.get(
        '/api/v1/lookups/governorates/$governorateId/districts',
      );
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final results = <DistrictEntity>[];
      for (final item in _extractDataList(response.data)) {
        final map = _asMap(item);
        final id = _string(map['id'] ?? map['district_id']);
        final name = _string(map['name'] ?? map['district_name']);
        if (id.isEmpty || name.isEmpty) continue;
        final districtGovernorateId = _string(
          map['governorate_id'] ?? map['governorateId'],
          governorateId,
        );
        results.add(
          DistrictEntity(
            id: id,
            name: name,
            governorateId: districtGovernorateId,
          ),
        );
      }
      return results;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<String> uploadImage(String filePath) async {
    final defaultException = _ExceptionCode.failedToUploadImage;

    Future<String> uploadWithFieldName(String fieldName) async {
      final response = await httpClient.postMultipart(
        '/api/v1/upload/image',
        files: {
          fieldName: [filePath],
        },
      );
      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }
      final data = _extractDataMap(response.data);
      final url = _string(
        data['url'] ??
            data['image_url'] ??
            data['imageUrl'] ??
            data['file_url'] ??
            data['fileUrl'] ??
            data['path'],
      );
      if (url.isEmpty) {
        throw _Exception(
          code: defaultException,
          message: 'Image upload did not return a valid URL.',
        );
      }
      return url;
    }

    try {
      return await uploadWithFieldName('image');
    } on HttpClientResponse catch (errorResponse) {
      if (_canRetryUploadWithFileField(errorResponse)) {
        try {
          return await uploadWithFieldName('file');
        } on HttpClientResponse catch (retryErrorResponse) {
          handleHttpClientErrorResponse(defaultException, retryErrorResponse);
        }
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
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
    final defaultException = _ExceptionCode.failedToRegister;
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

      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final data = _extractDataMap(response.data);
      final studentCode = _string(
        data['student_code'] ?? data['studentCode'] ?? data['code'],
      );
      if (studentCode.isEmpty) {
        throw _Exception(
          code: defaultException,
          message: 'Registration response did not include student code.',
        );
      }

      final otpExpiresInSeconds = _intOrNull(
        data['otp_expires_in_seconds'] ?? data['otpExpiresInSeconds'],
      );

      return (
        studentCode: studentCode,
        otpExpiresInSeconds: otpExpiresInSeconds,
      );
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 409 ||
          _isDuplicatePhoneError(errorResponse)) {
        throw _Exception(
          code: _ExceptionCode.phoneAlreadyExists,
          message: httpClient.extractErrorMessage(errorResponse),
        );
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e) {
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  static bool _isSuccessStatus(int statusCode) {
    return statusCode == 200 || statusCode == 201;
  }

  bool _isDuplicatePhoneError(HttpClientResponse response) {
    final message =
        httpClient.extractErrorMessage(response)?.toLowerCase().trim() ?? '';
    if (message.isEmpty) return false;
    final mentionsPhone =
        message.contains('phone') || message.contains('mobile');
    final mentionsConflict =
        message.contains('exist') ||
        message.contains('taken') ||
        message.contains('used') ||
        message.contains('registered') ||
        message.contains('duplicate');
    return mentionsPhone && mentionsConflict;
  }

  bool _canRetryUploadWithFileField(HttpClientResponse response) {
    if (response.statusCode == 400 ||
        response.statusCode == 415 ||
        response.statusCode == 422) {
      return true;
    }
    final message =
        httpClient.extractErrorMessage(response)?.toLowerCase().trim() ?? '';
    return message.contains('image') || message.contains('file');
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

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map(
        (key, val) => MapEntry(key.toString(), val),
      );
    }
    return <String, dynamic>{};
  }

  static List<dynamic> _asList(dynamic value) {
    if (value is List<dynamic>) return value;
    if (value is List) return List<dynamic>.from(value);
    return <dynamic>[];
  }

  static List<dynamic> _extractDataList(dynamic responseData) {
    final root = _asMap(responseData);
    final data = root['data'];

    if (data is List) return List<dynamic>.from(data);
    if (data is Map) {
      final map = _asMap(data);
      final items = map['items'] ?? map['results'] ?? map['records'];
      return _asList(items);
    }

    return _asList(responseData);
  }

  static Map<String, dynamic> _extractDataMap(dynamic responseData) {
    final root = _asMap(responseData);
    final data = root['data'];
    if (data is Map) return _asMap(data);
    return root;
  }

  static String _string(dynamic value, [String fallback = '']) {
    if (value == null) return fallback;
    final parsed = value.toString().trim();
    if (parsed.isEmpty) return fallback;
    return parsed;
  }

  static String? _stringOrNull(dynamic value) {
    final parsed = _string(value);
    return parsed.isEmpty ? null : parsed;
  }

  static bool? _boolOrNull(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;

    final normalized = value.toString().trim().toLowerCase();
    if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
      return true;
    }
    if (normalized == 'false' || normalized == '0' || normalized == 'no') {
      return false;
    }
    return null;
  }

  static int? _intOrNull(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }
}
