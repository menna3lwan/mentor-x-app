part of 'package:mentorx_core/mentorx_core.dart';

final class SupportInfoEntity extends Equatable {
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

  SupportInfoEntity copyWith({
    String? whatsapp,
    String? email,
    String? workingHours,
  }) {
    return SupportInfoEntity(
      whatsapp: whatsapp ?? this.whatsapp,
      email: email ?? this.email,
      workingHours: workingHours ?? this.workingHours,
    );
  }
}
