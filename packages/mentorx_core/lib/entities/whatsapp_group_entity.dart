part of '../mentorx_core.dart';

final class WhatsAppGroupEntity extends Equatable {
  final String id;
  final String name;
  final String inviteLink;
  final bool isActive;

  const WhatsAppGroupEntity({
    required this.id,
    required this.name,
    required this.inviteLink,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [id, name, inviteLink, isActive];
}
