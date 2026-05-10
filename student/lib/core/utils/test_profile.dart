import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://98.94.45.209:8081',
    headers: {
      'Content-Type': 'application/json',
      'X-Device-Id': 'd0fc1d89b763642b4b739eabad866f49112d305f3b2c3b309ece243430cacec1',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiU1RVREVOVCIsInBob25lIjoiMDEyMDEyNTA3MDYiLCJzZXNzaW9uSWQiOiJmYWMzOGU3MS04Y2E4LTQ5ZDAtYWJmNy0zZmFlMTRiNzczZDUiLCJ0b2tlblR5cGUiOiJBQ0NFU1MiLCJ1c2VySWQiOjMyLCJkZXZpY2VJZCI6ImQwZmMxZDg5Yjc2MzY0MmI0YjczOWVhYmFkODY2ZjQ5MTEyZDMwNWYzYjJjM2IzMDllY2UyNDM0MzBjYWNlYzEiLCJzdWIiOiIwMTIwMTI1MDcwNiIsImlhdCI6MTc3ODQyNDEzMCwiZXhwIjoxNzc4NDI1OTMwfQ.Ffw39oQWdeNyCNSWzvBMHwGtex29EITzeZ-IodsNKVE',
    },
  ));

  print('--- Testing Student Profile with existing token ---');
  try {
    final profileResponse = await dio.get('/api/student/profile');
    print('Profile Status: ${profileResponse.statusCode}');
    print('Profile Body: ${profileResponse.data}');
    
    final walletResponse = await dio.get('/api/payment/wallet/balance');
    print('Wallet: ${walletResponse.data}');
    
    final unreadResponse = await dio.get('/api/notifications/unread-count');
    print('Unread: ${unreadResponse.data}');
    
    final bannersResponse = await dio.get('/api/banners/active', queryParameters: {'placement': 'home'});
    print('Banners: ${bannersResponse.data}');
    
    final enrollmentsResponse = await dio.get('/api/enrollments/my-enrollments', queryParameters: {'size': 5, 'sort': 'lastAccessedAt,desc'});
    print('Enrollments: ${enrollmentsResponse.data}');
    
    final coursesResponse = await dio.get('/api/courses', queryParameters: {'featured': true, 'size': 6});
    print('Courses: ${coursesResponse.data}');
    
    final announcementsResponse = await dio.get('/api/announcements/active', queryParameters: {'limit': 3});
    print('Announcements: ${announcementsResponse.data}');
  } catch (e) {
    if (e is DioException) {
      print('Error: ${e.response?.statusCode} - ${e.response?.data}');
    } else {
      print('Error: $e');
    }
  }
}
