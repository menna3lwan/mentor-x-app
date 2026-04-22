part of '../../mock_data.dart';

final class MockStudentGenerator {
  MockStudentGenerator._();

  static final Faker _faker = Faker();

  static StudentEntity generate({required String phoneNumber}) {
    final now = DateTime.now();
    final firstName = _faker.person.firstName();
    final lastName = _faker.person.lastName();
    
    return StudentEntity(
      id: _faker.guid.guid(),
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: _faker.internet.email(),
      status: StudentStatus.active,
      gender: _faker.randomGenerator.boolean() ? Gender.male : Gender.female,
      dateOfBirth: now.subtract(const Duration(days: 365 * 16)),
      gradeName: 'Grade 10',
      centerName: 'Main Center',
      createdAt: now.subtract(
        Duration(days: _faker.randomGenerator.integer(365, min: 1)),
      ),
      updatedAt: now,
    );
  }
}
