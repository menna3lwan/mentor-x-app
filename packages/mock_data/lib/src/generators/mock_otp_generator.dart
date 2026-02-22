import 'package:faker/faker.dart';

final class MockOtpGenerator {
  MockOtpGenerator._();

  static final Faker _faker = Faker();

  static String generate({int length = 6}) {
    final max = int.parse('9' * length);
    final min = int.parse('1${'0' * (length - 1)}');
    return _faker.randomGenerator.integer(max, min: min).toString();
  }
}
