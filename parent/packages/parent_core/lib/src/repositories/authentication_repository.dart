import '../entities/parent_entity.dart';

abstract interface class AuthenticationRepository {
  Future<void> initialize();
  Future<ParentEntity> login({required String phone, required String password});
  Future<void> logout();
  Future<ParentEntity?> getCachedUser();
  Future<void> sendOtp(String phone);
  Future<ParentEntity> verifyOtp(String phone, String code);
}
