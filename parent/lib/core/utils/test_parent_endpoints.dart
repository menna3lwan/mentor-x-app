import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://98.94.45.209:8081',
    headers: {
      'Content-Type': 'application/json',
      'X-Device-Id': 'parent-tester-device',
    },
  ));

  print('--- Testing Parent Login ---');
  try {
    final loginResponse = await dio.post('/api/auth/parent/login', data: {
      'phone': '01201250706',
      'password': 'string',
      'device_hash': 'parent-tester-hash',
      'device_name': 'Parent Phone',
      'device_model': 'Simulator',
      'os_version': 'macOS',
      'app_version': '1.0.0',
    });

    print('Login Status: ${loginResponse.statusCode}');
    print('Login Body: ${loginResponse.data}');

    final String token = loginResponse.data['token'] ?? loginResponse.data['data']?['token'];
    final String deviceId = loginResponse.data['deviceId'] ?? loginResponse.data['data']?['deviceId'];
    
    if (token != null) {
      print('Token acquired. Testing Parent Summary...');
      dio.options.headers['Authorization'] = 'Bearer $token';
      if (deviceId != null) {
        dio.options.headers['X-Device-Id'] = deviceId;
      }
      
      final summaryResponse = await dio.get('/api/parent/dashboard/summary');
      print('Summary Status: ${summaryResponse.statusCode}');
      print('Summary Body: ${summaryResponse.data}');
      
      final activityResponse = await dio.get('/api/parent/recent-activity');
      print('Activity Status: ${activityResponse.statusCode}');
      print('Activity Body: ${activityResponse.data}');
    } else {
      print('No token found.');
    }
  } catch (e) {
    if (e is DioException) {
      print('Error: ${e.response?.statusCode} - ${e.response?.data}');
    } else {
      print('Error: $e');
    }
  }
}
