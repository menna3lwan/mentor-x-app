part of 'package:mentorx_core/mentorx_core.dart';

class StudentRegistrationResponseEntity extends Equatable {
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
}
