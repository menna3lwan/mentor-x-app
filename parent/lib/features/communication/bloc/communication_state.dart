part of 'communication_bloc.dart';

enum CommunicationStatus { initial, loading, success, failure }

final class CommunicationState extends Equatable {
  final CommunicationStatus status;
  final List<NotificationEntity> notifications;
  final List<AnnouncementEntity> announcements;
  final List<WhatsAppGroupEntity> whatsAppGroups;
  final String? errorMessage;

  const CommunicationState({
    this.status = CommunicationStatus.initial,
    this.notifications = const [],
    this.announcements = const [],
    this.whatsAppGroups = const [],
    this.errorMessage,
  });

  bool get isLoading => status == CommunicationStatus.loading;

  CommunicationState copyWith({
    CommunicationStatus? status,
    List<NotificationEntity>? notifications,
    List<AnnouncementEntity>? announcements,
    List<WhatsAppGroupEntity>? whatsAppGroups,
    String? errorMessage,
  }) {
    return CommunicationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      announcements: announcements ?? this.announcements,
      whatsAppGroups: whatsAppGroups ?? this.whatsAppGroups,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        notifications,
        announcements,
        whatsAppGroups,
        errorMessage,
      ];
}
