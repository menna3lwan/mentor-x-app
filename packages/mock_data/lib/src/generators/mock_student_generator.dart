part of '../../mock_data.dart';

final class MockStudentGenerator {
  MockStudentGenerator._();

  static final Faker _faker = Faker();

  static StudentEntity generate({required String phoneNumber}) {
    final now = DateTime.now();
    return StudentEntity(
      id: _faker.guid.guid(),
      name: _faker.person.name(),
      phoneNumber: phoneNumber,
      email: _faker.internet.email(),
      createdAt: now.subtract(
        Duration(days: _faker.randomGenerator.integer(365, min: 1)),
      ),
      updatedAt: now,
    );
  }
}
