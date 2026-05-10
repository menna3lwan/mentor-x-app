import 'package:dio/dio.dart';
import 'package:mentorx_core/mentorx_core.dart';

void main() async {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://98.94.45.209:8081',
    headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiU1RVREVOVCIsInBob25lIjoiMDEyMDEyNTA3MDYiLCJzZXNzaW9uSWQiOiJmMWM2MWVlZi0zNjc5LTQ1NWUtOWViNC04NDZjYjk2OWM2MTIiLCJ0b2tlblR5cGUiOiJBQ0NFU1MiLCJ1c2VySWQiOjMyLCJkZXZpY2VJZCI6Ijc2NDkxMTg0NjNhMjFlNzAzMmQ5YjlmMjhkYjFkMDFhZTFhYmI1NzkwZDUxMmZhMDVlODc5ZTM1YWM4Zjg5YWEiLCJzdWIiOiIwMTIwMTI1MDcwNiIsImlhdCI6MTc3ODE1NDE0NywiZXhwIjoxNzc4MTU1OTQ3fQ.VaInwK8soefNAok8d2Tnq0crh1KelbOWG9nmIU6EzCA',
      NetworkConstants.deviceIdHeader: '19112080d7b69fbd705d0a854da8a57649b9aed326c81b6d73b8fa46119ca65a',
      'Accept-Language': 'ar',
    },
  ));

  print('--- Testing Banners ---');
  await _test(dio, '/api/banners/active?placement=home');

  print('\n--- Testing Categories ---');
  await _test(dio, '/api/categories');

  print('\n--- Testing Course Catalog ---');
  await _test(dio, '/api/courses?size=5');

  // Assuming we get a course ID from catalog for further testing
  final courseId = '3'; // Example course ID from previous logs

  print('\n--- Testing Sessions for Course $courseId ---');
  await _test(dio, '/api/sessions/course/$courseId');

  final sessionId = '1'; // Example session ID

  print('\n--- Testing Weeks for Session $sessionId ---');
  await _test(dio, '/api/weeks/session/$sessionId');
}

Future<void> _test(Dio dio, String path) async {
  try {
    final response = await dio.get(path);
    print('SUCCESS [$path]: ${response.statusCode}');
    print('Data: ${response.data}');
  } on DioException catch (e) {
    print('FAILED [$path]: ${e.response?.statusCode}');
    print('Error: ${e.response?.data}');
  }
}
