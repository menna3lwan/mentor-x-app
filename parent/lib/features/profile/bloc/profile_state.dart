part of 'profile_bloc.dart';

/// Tri-state lifecycle for the initial profile fetch.
enum ProfileLoadStatus { initial, loading, loaded, failure }

/// Lifecycle for save (PUT) and avatar-upload operations. Both share the
/// same enum so the UI can render a single spinner regardless of which
/// operation is in-flight.
enum ProfileSaveStatus { idle, saving, success, failure }

final class ProfileState extends Equatable {
  final ProfileLoadStatus loadStatus;
  final ProfileSaveStatus saveStatus;
  final ProfileSaveStatus avatarStatus;
  final ParentEntity? profile;
  final String draftName;
  final String? errorMessage;

  const ProfileState({
    required this.loadStatus,
    required this.saveStatus,
    required this.avatarStatus,
    required this.draftName,
    this.profile,
    this.errorMessage,
  });

  factory ProfileState.initial([ParentEntity? cached]) {
    return ProfileState(
      loadStatus: cached != null
          ? ProfileLoadStatus.loaded
          : ProfileLoadStatus.initial,
      saveStatus: ProfileSaveStatus.idle,
      avatarStatus: ProfileSaveStatus.idle,
      profile: cached,
      draftName: cached?.fullName ?? '',
    );
  }

  bool get isLoading => loadStatus == ProfileLoadStatus.loading;
  bool get isSaving => saveStatus == ProfileSaveStatus.saving;
  bool get isUploadingAvatar => avatarStatus == ProfileSaveStatus.saving;
  bool get hasProfile => profile != null;

  ProfileState copyWith({
    ProfileLoadStatus? loadStatus,
    ProfileSaveStatus? saveStatus,
    ProfileSaveStatus? avatarStatus,
    ParentEntity? profile,
    String? draftName,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileState(
      loadStatus: loadStatus ?? this.loadStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      avatarStatus: avatarStatus ?? this.avatarStatus,
      profile: profile ?? this.profile,
      draftName: draftName ?? this.draftName,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    saveStatus,
    avatarStatus,
    profile,
    draftName,
    errorMessage,
  ];
}
