import 'dart:convert';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:device_info_service/device_info_service.dart';
import 'src/models/registration_models.dart';

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
  final DeviceInfoService deviceInfoService;

  DioStudentRegistrationRepository({
    required this.httpClient,
    DeviceInfoService? deviceInfoService,
  }) : deviceInfoService = deviceInfoService ?? DeviceInfoServiceImpl();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> startRegistration({
    required String phone,
  }) async {
    try {
      await httpClient.post(
        '/api/student/register/start',
        data: {
          'phone': phone,
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
  Future<void> verifyOtp({
    required String phone,
    required String otp,
    int? tenantId,
  }) async {
    try {
      await httpClient.post(
        '/api/auth/verify-otp',
        data: {
          'phone': phone,
          'otp': int.tryParse(otp) ?? otp,
        },
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.invalidOtp,
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
  Future<StudentRegistrationResponseEntity> completeRegistration({
    required String firstName,
    required String secondName,
    required String thirdName,
    required String fourthName,
    required String governorateId,
    required String area,
    required String gradeId,
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
      final requestData = {
        'firstName': firstName,
        'secondName': secondName,
        'thirdName': thirdName,
        'fourthName': fourthName,
        'governorate': governorateId,
        'area': area,
        'grade': gradeId,
        'online': online,
        'otp': int.tryParse(otp) ?? otp,
        'parentPhone': parentPhone,
        'phone': phone,
        'password': password,
        if (schoolName != null) 'schoolName': schoolName,
        if (educationDepartment != null)
          'educationDepartment': educationDepartment,
        if (centerName != null) 'centerName': centerName,
      };

      final files = <String, List<String>>{};
      if (profileImagePath != null) {
        files['profileImage'] = [profileImagePath];
      }
      if (identityDocumentPath != null) {
        files['identityDocument'] = [identityDocumentPath];
      }

      final response = await httpClient.postMultipart(
        '/api/student/register/complete',
        data: {
          'data': jsonEncode(requestData),
        },
        files: files,
      );

      final data = response.asMap();

      return StudentRegistrationResponseEntity(
        studentCode: stringOrNull(data['studentCode'] ?? data['student_code']),
        token: stringOrNull(data['token']),
        status: stringOrNull(data['status']) ?? 'PENDING',
        phone: stringOrNull(data['phone']),
        message: stringOrNull(data['message']),
        redirectTo: stringOrNull(data['redirectTo'] ?? data['redirect_to']),
        supportWhatsApp: stringOrNull(
          data['supportWhatsApp'] ?? data['support_whatsapp'],
        ),
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
      final response = await httpClient.get(
        '/api/public/governorates',
      );
      final data = response.asList();
      return data
          .map((item) => GovernorateModel.fromJson(asMap(item)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadGovernorates,
      );
    }
  }

  @override
  Future<List<GovernorateEntity>> getGovernoratesWithAreas() async {
    try {
      final response = await httpClient.get(
        '/api/public/governorates/with-areas',
      );
      final data = response.asList();
      return data
          .map((item) => GovernorateModel.fromJson(asMap(item)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadGovernorates,
      );
    }
  }

  @override
  Future<List<AreaEntity>> getAreas(String governorateId) async {
    try {
      // Backend GeoController: GET /api/public/governorates/{id}/areas
      final response = await httpClient.get(
        '/api/public/governorates/$governorateId/areas',
      );
      final data = response.asList();
      return data.map((item) => AreaModel.fromJson(asMap(item))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLoadAreas,
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getCenters({String? governorate}) async {
    try {
      final String path = governorate != null
          ? '/api/centers/governorate/$governorate'
          : '/api/centers';
      final response = await httpClient.get(path);
      final data = response.asList();
      return data.map((e) => asMap(e)).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }

  @override
  Future<StudentApplicationInfoEntity> getApplicationInfo() async {
    try {
      final response = await httpClient.get(
        '/api/student/register/application-info',
      );
      final data = response.asMap();
      return StudentApplicationInfoModel.fromJson(data);
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
      final data = response.asMap();
      return boolOrNull(data['exists']) ?? false;
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 409) {
        return true; // Status code conflict means it exists
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }
}
