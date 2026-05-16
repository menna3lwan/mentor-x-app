part of 'package:mentorx_core/mentorx_core.dart';

final class StudentRegistrationResponseEntity extends Equatable {
  final String? studentCode;
  final String? token;
  final String status;
  final String? phone;
  final String? message;
  final String? redirectTo;
  final String? supportWhatsApp;

  const StudentRegistrationResponseEntity({
    this.studentCode,
    this.token,
    required this.status,
    this.phone,
    this.message,
    this.redirectTo,
    this.supportWhatsApp,
  });

  @override
  List<Object?> get props => [
        studentCode,
        token,
        status,
        phone,
        message,
        redirectTo,
        supportWhatsApp,
      ];

  StudentRegistrationResponseEntity copyWith({
    MentorXNullableValue<String?>? studentCode,
    MentorXNullableValue<String?>? token,
    String? status,
    MentorXNullableValue<String?>? phone,
    MentorXNullableValue<String?>? message,
    MentorXNullableValue<String?>? redirectTo,
    MentorXNullableValue<String?>? supportWhatsApp,
  }) {
    return StudentRegistrationResponseEntity(
      studentCode: studentCode != null ? studentCode.value : this.studentCode,
      token: token != null ? token.value : this.token,
      status: status ?? this.status,
      phone: phone != null ? phone.value : this.phone,
      message: message != null ? message.value : this.message,
      redirectTo: redirectTo != null ? redirectTo.value : this.redirectTo,
      supportWhatsApp: supportWhatsApp != null ? supportWhatsApp.value : this.supportWhatsApp,
    );
  }
}
