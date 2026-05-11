import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';

final class MockStudentRegistrationRepository
    implements StudentRegistrationRepository {
  final Duration delay;

  const MockStudentRegistrationRepository({
    this.delay = const Duration(milliseconds: 500),
  });

  @override
  Future<void> initialize() async {
    await Future.delayed(delay);
  }

  @override
  Future<void> startRegistration({
    required String phone,
  }) async {
    await Future.delayed(delay);
    // Simulate phone already exists for a specific number
    if (phone == '01000000000') {
      throw StudentRegistrationException(
        code: StudentRegistrationExceptionCode.phoneAlreadyExists,
        message: 'This phone number is already registered.',
      );
    }
  }

  @override
  Future<void> resendOtp(String phone) async {
    await Future.delayed(delay);
  }

  @override
  Future<void> verifyOtp({
    required String phone,
    required String otp,
    int? tenantId,
  }) async {
    await Future.delayed(delay);
    if (otp != '123456') {
      throw StudentRegistrationException(
        code: StudentRegistrationExceptionCode.invalidOtp,
        message: 'Invalid verification code. Please use 123456 for testing.',
      );
    }
  }

  @override
  Future<StudentRegistrationResponseEntity> completeRegistration({
    required String firstName,
    required String secondName,
    required String thirdName,
    required String fourthName,
    required String governorateId,
    required String area,
    required String gradeId,
    required bool online,
    required String otp,
    required String parentPhone,
    required String phone,
    required String password,
    required String confirmPassword,
    String? schoolName,
    String? educationDepartment,
    String? centerName,
    String? profileImagePath,
    String? identityDocumentPath,
  }) async {
    await Future.delayed(delay);
    
    // Simulate OTP verification
    if (otp != '123456') {
      throw StudentRegistrationException(
        code: StudentRegistrationExceptionCode.invalidOtp,
        message: 'Invalid verification code. Please use 123456 for testing.',
      );
    }
    return const StudentRegistrationResponseEntity(
      studentCode: 'STU-12345',
      status: 'pending',
    );
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() async {
    await Future.delayed(delay);
    return [
      const GovernorateEntity(id: '1', name: 'Cairo'),
      const GovernorateEntity(id: '2', name: 'Giza'),
      const GovernorateEntity(id: '3', name: 'Alexandria'),
    ];
  }

  @override
  Future<List<String>> getAreas(String governorateId) async {
    await Future.delayed(delay);
    if (governorateId == '1' || governorateId == 'Cairo') {
      return ['Maadi', 'Nasr City', 'Heliopolis', 'Zamalek'];
    } else if (governorateId == '2' || governorateId == 'Giza') {
      return ['6th of October', 'Dokki', 'Mohandessin', 'Sheikh Zayed'];
    }
    return ['Sidi Gaber', 'Stanley', 'Montaza', 'Smouha'];
  }

  @override
  Future<StudentApplicationInfoEntity> getApplicationInfo() async {
    await Future.delayed(delay);
    return const StudentApplicationInfoEntity(
      requiredDocuments: ['National ID', 'Profile Photo'],
      supportInfo: SupportInfoEntity(
        whatsapp: '+20123456789',
        email: 'support@mentorx.com',
        workingHours: '9 AM - 6 PM',
      ),
      steps: [
        RegistrationStepEntity(
          step: '1',
          title: 'Start',
          description: 'Enter your phone number',
        ),
      ],
      grades: [
        GradeEntity(id: '1', name: 'Primary 1'),
        GradeEntity(id: '2', name: 'Primary 2'),
        GradeEntity(id: '3', name: 'Primary 3'),
        GradeEntity(id: '4', name: 'Secondary 1'),
        GradeEntity(id: '5', name: 'Secondary 2'),
        GradeEntity(id: '6', name: 'Secondary 3'),
      ],
    );
  }

  @override
  Future<bool> checkPhone(String phone) async {
    await Future.delayed(delay);
    // Simulate uniqueness (except for a specific testing number)
    return phone != '01000000000';
  }
}
