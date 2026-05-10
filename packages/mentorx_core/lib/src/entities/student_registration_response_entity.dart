part of 'package:mentorx_core/mentorx_core.dart';

final class StudentRegistrationResponseEntity extends Equatable {
  final String? studentCode;
  final String? token;
  final String status;

  const StudentRegistrationResponseEntity({
    this.studentCode,
    this.token,
    required this.status,
  });

  @override
  List<Object?> get props => [studentCode, token, status];

  StudentRegistrationResponseEntity copyWith({
    MentorXNullableValue<String?>? studentCode,
    MentorXNullableValue<String?>? token,
    String? status,
  }) {
    return StudentRegistrationResponseEntity(
      studentCode: studentCode != null ? studentCode.value : this.studentCode,
      token: token != null ? token.value : this.token,
      status: status ?? this.status,
    );
  }
}
