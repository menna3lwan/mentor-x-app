import 'dart:convert';
import 'dart:io';

void main() async {
  const String baseUrl = 'http://98.94.45.209:8080';
  const String phone = '01192789890';
  const String password = 'string';

  final httpClient = HttpClient();

  print('--- Attempting to login to get current token ---');
  try {
    final loginRequest = await httpClient.postUrl(Uri.parse('$baseUrl/api/auth/student/login'));
    loginRequest.headers.add('Content-Type', 'application/json');
    loginRequest.write(jsonEncode({'phone': phone, 'password': password}));
    
    final loginResponse = await loginRequest.close();
    final loginBody = await loginResponse.transform(utf8.decoder).join();
    final loginJson = jsonDecode(loginBody);

    if (loginJson['success'] == true) {
      final String token = loginJson['token'];
      final String deviceId = loginJson['deviceId'];
      print('Login successful. Now logging out...');
      
      final logoutRequest = await httpClient.postUrl(Uri.parse('$baseUrl/api/auth/logout'));
      logoutRequest.headers.add('Authorization', 'Bearer $token');
      logoutRequest.headers.add('X-Device-Id', deviceId);
      logoutRequest.headers.add('Accept', 'application/json');
      
      final logoutResponse = await logoutRequest.close();
      final logoutBody = await logoutResponse.transform(utf8.decoder).join();
      print('Logout Status: ${logoutResponse.statusCode}');
      print('Logout Response: $logoutBody');
    } else {
      print('Login failed (might already be logged in): $loginBody');
      
      // If already logged in, we need the token/deviceId to logout. 
      // But we don't have them easily unless we store them.
      // However, we can try to "force logout" if the API supports it.
      print('Trying /api/auth/logout with fallback headers if possible...');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    httpClient.close();
  }
}
