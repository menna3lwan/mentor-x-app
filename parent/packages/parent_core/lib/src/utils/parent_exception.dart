import 'package:mentorx_core/mentorx_core.dart';

enum AuthenticationExceptionCode {
  unknown,
  invalidCredentials,
  networkError,
  sessionExpired,
  invalidOtp,
}

final class AuthenticationException
    extends MentorXException<AuthenticationExceptionCode> {
  const AuthenticationException({
    required super.code,
    super.message,
  });
}
