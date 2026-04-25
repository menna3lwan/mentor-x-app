part of 'app_session_cubit.dart';

final class AppSessionState extends Equatable {
  const AppSessionState({
    this.studentName = '',
    this.studentNameAr = '',
    this.studentCode = '',
    this.phone = '',
    this.grade = '',
    this.gradeAr = '',
    this.center = '',
    this.centerAr = '',
    this.school = '',
    this.schoolAr = '',
    this.walletBalance = 0.0,
    this.attendancePercent = 0.0,
    this.averageScore = 0.0,
    this.pendingAssignments = 0,
  });

  final String studentName;
  final String studentNameAr;
  final String studentCode;
  final String phone;
  final String grade;
  final String gradeAr;
  final String center;
  final String centerAr;
  final String school;
  final String schoolAr;
  final double walletBalance;
  final double attendancePercent;
  final double averageScore;
  final int pendingAssignments;

  AppSessionState copyWith({
    String? studentName,
    String? studentNameAr,
    String? studentCode,
    String? phone,
    String? grade,
    String? gradeAr,
    String? center,
    String? centerAr,
    String? school,
    String? schoolAr,
    double? walletBalance,
    double? attendancePercent,
    double? averageScore,
    int? pendingAssignments,
  }) {
    return AppSessionState(
      studentName: studentName ?? this.studentName,
      studentNameAr: studentNameAr ?? this.studentNameAr,
      studentCode: studentCode ?? this.studentCode,
      phone: phone ?? this.phone,
      grade: grade ?? this.grade,
      gradeAr: gradeAr ?? this.gradeAr,
      center: center ?? this.center,
      centerAr: centerAr ?? this.centerAr,
      school: school ?? this.school,
      schoolAr: schoolAr ?? this.schoolAr,
      walletBalance: walletBalance ?? this.walletBalance,
      attendancePercent: attendancePercent ?? this.attendancePercent,
      averageScore: averageScore ?? this.averageScore,
      pendingAssignments: pendingAssignments ?? this.pendingAssignments,
    );
  }

  @override
  List<Object?> get props => [
    studentName,
    studentNameAr,
    studentCode,
    phone,
    grade,
    gradeAr,
    center,
    centerAr,
    school,
    schoolAr,
    walletBalance,
    attendancePercent,
    averageScore,
    pendingAssignments,
  ];
}
