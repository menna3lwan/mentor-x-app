part of 'package:mentorx_core/mentorx_core.dart';

class RegistrationStepEntity extends Equatable {
  final String step;
  final String title;
  final String description;
  final bool isCompleted;

  const RegistrationStepEntity({
    required this.step,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [step, title, description, isCompleted];
}
