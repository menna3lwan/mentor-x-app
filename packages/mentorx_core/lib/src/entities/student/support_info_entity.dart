part of 'package:mentorx_core/mentorx_core.dart';

class SupportInfoEntity extends Equatable {
  final String whatsapp;
  final String email;
  final String workingHours;

  const SupportInfoEntity({
    required this.whatsapp,
    required this.email,
    required this.workingHours,
  });

  @override
  List<Object?> get props => [whatsapp, email, workingHours];
}
