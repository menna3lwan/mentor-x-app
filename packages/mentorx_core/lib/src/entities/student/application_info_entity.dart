part of 'package:mentorx_core/mentorx_core.dart';

class StudentApplicationInfoEntity extends Equatable {
  final List<String> requiredDocuments;
  final SupportInfoEntity supportInfo;
  final List<RegistrationStepEntity> steps;
  final List<GradeEntity> grades;

  const StudentApplicationInfoEntity({
    required this.requiredDocuments,
    required this.supportInfo,
    required this.steps,
    required this.grades,
  });

  @override
  List<Object?> get props => [requiredDocuments, supportInfo, steps, grades];
}
