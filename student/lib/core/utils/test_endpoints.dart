import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://98.94.45.209:8081', // Update with actual dev/prod URL if different
    headers: {
      'Content-Type': 'application/json',
      'X-Device-Id': 'test-device-id',
    },
  ));

  print('--- Testing Student Login ---');
  try {
    final loginResponse = await dio.post('/api/auth/student/login', data: {
      'phone': '01201250706',
      'password': 'string',
      'device_hash': 'test-device-hash-123',
      'device_name': 'Tester Phone',
      'device_model': 'Simulator',
      'os_version': 'macOS',
      'app_version': '1.0.0',
    });

    print('Login Status: ${loginResponse.statusCode}');
    print('Login Body: ${loginResponse.data}');

    final String token = loginResponse.data['token'] ?? loginResponse.data['data']?['token'];
    final String deviceId = loginResponse.data['deviceId'] ?? loginResponse.data['data']?['deviceId'];
    
    if (token != null) {
      print('Token acquired. DeviceId: $deviceId. Testing Profile...');
      dio.options.headers['Authorization'] = 'Bearer $token';
      if (deviceId != null) {
        dio.options.headers['X-Device-Id'] = deviceId;
      }
      
      final profileResponse = await dio.get('/api/student/profile');
      print('Profile Status: ${profileResponse.statusCode}');
      print('Profile Body: ${profileResponse.data}');
      
      final summaryResponse = await dio.get('/api/student/dashboard/summary');
      print('Summary Status: ${summaryResponse.statusCode}');
      print('Summary Body: ${summaryResponse.data}');
    } else {
      print('No token found in response.');
    }
  } catch (e) {
    if (e is DioException) {
      print('Error: ${e.response?.statusCode} - ${e.response?.data}');
    } else {
      print('Error: $e');
    }
  }
}
