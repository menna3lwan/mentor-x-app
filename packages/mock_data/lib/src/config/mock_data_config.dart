part of '../../mock_data.dart';

final class MockDataConfig {
  MockDataConfig._();

  static const int otpLength = 6;
  static const Duration otpDuration = Duration(minutes: 5);
  static const Duration resendOtpDuration = Duration(seconds: 10);
}
