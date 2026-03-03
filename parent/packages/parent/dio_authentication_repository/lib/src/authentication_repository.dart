import 'package:parent_core/parent_core.dart';
import 'package:dio_http_client/dio_http_client.dart';

class DioAuthenticationRepository implements AuthenticationRepository {
  final DioHttpClient client;

  DioAuthenticationRepository({required this.client});

  @override
  Future<void> initialize() async {}

  @override
  Future<ParentEntity> login({
    required String phone,
    required String password,
  }) async {
    // API Call here
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    throw UnimplementedError();
  }

  @override
  Future<ParentEntity?> getCachedUser() async {
    return null;
  }

  @override
  Future<void> sendOtp(String phone) async {
    throw UnimplementedError();
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    throw UnimplementedError();
  }
}
