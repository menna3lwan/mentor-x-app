import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';

final class MockStudentRegistrationRepository
    implements StudentRegistrationRepository {
  @override
  Future<void> startRegistration({
    required String firstName,
    required String phone,
    required String parentPhone,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
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
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> completeRegistration({
    required String firstName,
    required String secondName,
    required String thirdName,
    required String fourthName,
    required String governorate,
    required String area,
    required String grade,
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
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate OTP verification
    if (otp != '123456') {
      throw StudentRegistrationException(
        code: StudentRegistrationExceptionCode.invalidOtp,
        message: 'Invalid verification code. Please use 123456 for testing.',
      );
    }
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const GovernorateEntity(id: '1', name: 'Cairo'),
      const GovernorateEntity(id: '2', name: 'Giza'),
      const GovernorateEntity(id: '3', name: 'Alexandria'),
    ];
  }

  @override
  Future<List<String>> getAreas(String governorate) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (governorate == 'Cairo') {
      return ['Maadi', 'Nasr City', 'Heliopolis', 'Zamalek'];
    } else if (governorate == 'Giza') {
      return ['6th of October', 'Dokki', 'Mohandessin', 'Sheikh Zayed'];
    }
    return ['Sidi Gaber', 'Stanley', 'Montaza', 'Smouha'];
  }

  @override
  Future<Map<String, dynamic>> getApplicationInfo() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'grades': [
        {'id': '1', 'name': 'Primary 1'},
        {'id': '2', 'name': 'Primary 2'},
        {'id': '3', 'name': 'Primary 3'},
        {'id': '4', 'name': 'Secondary 1'},
        {'id': '5', 'name': 'Secondary 2'},
        {'id': '6', 'name': 'Secondary 3'},
      ],
      'studyModes': ['Online', 'Center'],
    };
  }

  @override
  Future<bool> checkPhone(String phone) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate uniqueness (except for a specific testing number)
    return phone != '01000000000';
  }
}
