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
  Future<void> startRegistration({
    required String firstName,
    required String phone,
    required String parentPhone,
  }) async {
    try {
      await httpClient.post(
        '/api/student/register/start',
        data: {
          'firstName': firstName,
          'phone': phone,
          'parentPhone': parentPhone,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToStartRegistration,
      );
    }
  }

  @override
  Future<void> resendOtp(String phone) async {
    try {
      await httpClient.post(
        '/api/student/register/resend-otp',
        data: {
          'phone': phone,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResendOtp,
      );
    }
  }

  @override
  Future<void> completeRegistration({
    required String firstName,
    required String secondName,
    required String thirdName,
    required String fourthName,
    required String governorate,
    required String area,
    required String grade,
    required bool online,
    required String otp,
    required String parentPhone,
    required String phone,
    required String password,
    required String confirmPassword,
    String? schoolName,
    String? educationDepartment,
    String? centerName,
    String? profileImagePath,
    String? identityDocumentPath,
  }) async {
    try {
      final queryParameters = {
        'firstName': firstName,
        'secondName': secondName,
        'thirdName': thirdName,
        'fourthName': fourthName,
        'governorate': governorate,
        'area': area,
        'grade': grade,
        'online': online.toString(),
        'otp': otp,
        'parentPhone': parentPhone,
        'phone': phone,
        'password': password,
        'confirmPassword': confirmPassword,
        if (schoolName != null) 'schoolName': schoolName,
        if (educationDepartment != null) 'educationDepartment': educationDepartment,
        if (centerName != null) 'centerName': centerName,
      };

      final files = <String, List<String>>{};
      if (profileImagePath != null) {
        files['profileImage'] = [profileImagePath];
      }
      if (identityDocumentPath != null) {
        files['identityDocument'] = [identityDocumentPath];
      }

      await httpClient.postMultipart(
        '/api/student/register/complete',
        queryParameters: queryParameters,
        files: files,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToCompleteRegistration,
      );
    }
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() async {
    try {
      final response = await httpClient.get('/api/student/register/governorates');
      final data = asList(asMap(response.data)['data'] ?? asMap(response.data)['content'] ?? response.data);
      return data.map((item) {
        final map = asMap(item);
        if (item is String) {
          return GovernorateEntity(id: item, name: item);
        }
        return GovernorateEntity(
          id: stringOrEmpty(map['id'] ?? map['name']),
          name: stringOrEmpty(map['name']),
        );
      }).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadGovernorates,
      );
    }
  }

  @override
  Future<List<String>> getAreas(String governorate) async {
    try {
      final response = await httpClient.get(
        '/api/student/register/areas/$governorate',
      );
      final data = asList(asMap(response.data)['data'] ?? asMap(response.data)['content'] ?? response.data);
      return data.map((item) => item.toString()).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadAreas,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getApplicationInfo() async {
    try {
      final response = await httpClient.get('/api/student/register/application-info');
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadApplicationInfo,
      );
    }
  }

  @override
  Future<bool> checkPhone(String phone) async {
    try {
      final response = await httpClient.get(
        '/api/student/register/check-phone/$phone',
      );
      final data = asMap(response.data);
      return boolOrNull(data['available']) ?? true;
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 409) return false;
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }
}
