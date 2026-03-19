part of '../../mock_data.dart';

final class MockOtpGenerator {
  MockOtpGenerator._();

  static final Faker _faker = Faker();

  static String generate() {
    return _faker.randomGenerator.numbers(9, MockDataConfig.otpLength).join();
  }
}
