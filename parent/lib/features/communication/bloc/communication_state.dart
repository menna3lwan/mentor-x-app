part of 'communication_bloc.dart';

enum CommunicationSectionStatus { initial, loading, loaded, failure }

enum CommunicationSection { notifications, announcements, whatsAppGroups }

final class CommunicationAsyncSection<T> extends Equatable {
  final CommunicationSectionStatus status;
  final T? data;
  final String? errorMessage;

  const CommunicationAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const CommunicationAsyncSection.initial()
      : this._(status: CommunicationSectionStatus.initial);
  const CommunicationAsyncSection.loading({T? data})
      : this._(status: CommunicationSectionStatus.loading, data: data);
  const CommunicationAsyncSection.loaded(T data)
      : this._(status: CommunicationSectionStatus.loaded, data: data);
  const CommunicationAsyncSection.failure(String message, {T? data})
      : this._(
          status: CommunicationSectionStatus.failure,
          data: data,
          errorMessage: message,
        );

  bool get isInitial => status == CommunicationSectionStatus.initial;
  bool get isLoading => status == CommunicationSectionStatus.loading;
  bool get isLoaded => status == CommunicationSectionStatus.loaded;
  bool get isFailure => status == CommunicationSectionStatus.failure;

  CommunicationAsyncSection<T> toLoading() =>
      CommunicationAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class CommunicationState extends Equatable {
  final String? childId;
  final bool isRefreshing;

  final CommunicationAsyncSection<List<NotificationEntity>>
      notificationsSection;
  final CommunicationAsyncSection<List<AnnouncementEntity>>
      announcementsSection;
  final CommunicationAsyncSection<List<WhatsAppGroupEntity>>
      whatsAppGroupsSection;

  const CommunicationState({
    required this.childId,
    required this.isRefreshing,
    required this.notificationsSection,
    required this.announcementsSection,
    required this.whatsAppGroupsSection,
  });

  factory CommunicationState.initial() {
    return const CommunicationState(
      childId: null,
      isRefreshing: false,
      notificationsSection: CommunicationAsyncSection.initial(),
      announcementsSection: CommunicationAsyncSection.initial(),
      whatsAppGroupsSection: CommunicationAsyncSection.initial(),
    );
  }

  List<NotificationEntity> get notifications =>
      notificationsSection.data ?? const <NotificationEntity>[];

  List<AnnouncementEntity> get announcements =>
      announcementsSection.data ?? const <AnnouncementEntity>[];

  List<WhatsAppGroupEntity> get whatsAppGroups =>
      whatsAppGroupsSection.data ?? const <WhatsAppGroupEntity>[];

  CommunicationState copyWith({
    String? childId,
    bool? isRefreshing,
    CommunicationAsyncSection<List<NotificationEntity>>? notificationsSection,
    CommunicationAsyncSection<List<AnnouncementEntity>>? announcementsSection,
    CommunicationAsyncSection<List<WhatsAppGroupEntity>>?
        whatsAppGroupsSection,
  }) {
    return CommunicationState(
      childId: childId ?? this.childId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      notificationsSection:
          notificationsSection ?? this.notificationsSection,
      announcementsSection:
          announcementsSection ?? this.announcementsSection,
      whatsAppGroupsSection:
          whatsAppGroupsSection ?? this.whatsAppGroupsSection,
    );
  }

  @override
  List<Object?> get props => [
        childId,
        isRefreshing,
        notificationsSection,
        announcementsSection,
        whatsAppGroupsSection,
      ];
}
