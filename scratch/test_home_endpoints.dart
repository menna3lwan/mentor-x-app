import 'dart:convert';
import 'dart:io';

void main() async {
  const baseUrl = 'http://98.94.45.209:8080';
  final httpClient = HttpClient();
  
  String? token;
  String? deviceId;

  final rawHash = [
    Platform.operatingSystem,
    Platform.operatingSystemVersion,
    Platform.localHostname,
    Platform.localeName,
  ].join('|');
  final deviceHash = base64UrlEncode(utf8.encode(rawHash)).replaceAll('=', '');

  print('--- Attempting Login with Device Info ---');
  try {
    final loginReq = await httpClient.postUrl(Uri.parse('$baseUrl/api/auth/student/login'));
    loginReq.headers.add('Content-Type', 'application/json');
    loginReq.write(jsonEncode({
      'phone': '01192789890',
      'password': 'string',
      'device_hash': deviceHash,
      'device_name': 'Mobile Device',
      'device_model': Platform.operatingSystem,
      'os_version': Platform.operatingSystemVersion,
      'app_version': '1.0.0',
    }));
    
    final loginResp = await loginReq.close();
    final loginBody = await loginResp.transform(utf8.decoder).join();
    final loginJson = jsonDecode(loginBody);

    if (loginJson['success'] == true) {
      token = loginJson['token'];
      deviceId = loginJson['deviceId'];
      print('Login successful!');

      await runTests(httpClient, baseUrl, token!, deviceId!);
    } else {
      print('Login failed: $loginBody');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    if (token != null) {
      print('\n--- Performing Logout ---');
      try {
        final logoutReq = await httpClient.postUrl(Uri.parse('$baseUrl/api/auth/logout'));
        logoutReq.headers.add('Authorization', 'Bearer $token');
        if (deviceId != null) {
          logoutReq.headers.add('X-Device-Id', deviceId!);
        }
        final logoutResp = await logoutReq.close();
        print('Logout Status: ${logoutResp.statusCode}');
      } catch (e) {
        print('Logout failed: $e');
      }
    }
    httpClient.close();
  }
}

Future<void> runTests(HttpClient httpClient, String baseUrl, String token, String deviceId) async {
  final endpointVariations = [
    '/api/payment/wallet/balance',
    '/api/enrollments/my-enrollments',
    '/api/courses?featured=true',
    '/api/banners',
    '/api/announcements',
    '/api/notifications/unread-count',
  ];

  for (final path in endpointVariations) {
    print('\nTesting: $path');
    try {
      final req = await httpClient.getUrl(Uri.parse('$baseUrl$path'));
      req.headers.add('Authorization', 'Bearer $token');
      req.headers.add('X-Device-Id', deviceId);
      
      final resp = await req.close();
      final body = await resp.transform(utf8.decoder).join();
      
      print('Status: ${resp.statusCode}');
      if (resp.statusCode == 200) {
        try {
          final json = jsonDecode(body);
          print('Response: ${body.length > 200 ? body.substring(0, 200) + "..." : body}');
        } catch (_) {
          print('Body: $body');
        }
      } else {
        print('Error Body: $body');
      }
    } catch (e) {
      print('Request Failed: $e');
    }
  }
}
