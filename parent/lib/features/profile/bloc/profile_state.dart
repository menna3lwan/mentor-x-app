part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ParentEntity? profileData;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profileData,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ParentEntity? profileData,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileData: profileData ?? this.profileData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profileData, errorMessage];

  // Helper for settings data
  Map<String, dynamic> get settingsData => {
    'notificationsEnabled': true,
    'themeMode': 'system',
    'languageCode': 'en',
  };
}
