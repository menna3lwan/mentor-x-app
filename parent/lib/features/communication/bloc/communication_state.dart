part of 'communication_bloc.dart';

final class CommunicationState extends Equatable {
  final bool isLoading;
  final List<ParentNotificationItem> notifications;
  final List<ParentAnnouncementItem> announcements;
  final List<ParentWhatsappGroup> whatsappGroups;
  final String searchQuery;
  final String? errorMessage;

  const CommunicationState({
    this.isLoading = false,
    this.notifications = const [],
    this.announcements = const [],
    this.whatsappGroups = const [],
    this.searchQuery = '',
    this.errorMessage,
  });

  CommunicationState copyWith({
    bool? isLoading,
    List<ParentNotificationItem>? notifications,
    List<ParentAnnouncementItem>? announcements,
    List<ParentWhatsappGroup>? whatsappGroups,
    String? searchQuery,
    String? errorMessage,
  }) {
    return CommunicationState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
      announcements: announcements ?? this.announcements,
      whatsappGroups: whatsappGroups ?? this.whatsappGroups,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    notifications,
    announcements,
    whatsappGroups,
    searchQuery,
    errorMessage,
  ];
}
