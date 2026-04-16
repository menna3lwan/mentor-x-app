part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSaving;
  final ParentProfileData? profile;
  final ParentSettingsData? settings;
  final int saveSuccessTick;
  final String? errorMessage;

  const ProfileState({
    this.isLoading = false,
    this.isSaving = false,
    this.profile,
    this.settings,
    this.saveSuccessTick = 0,
    this.errorMessage,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? isSaving,
    ParentProfileData? profile,
    ParentSettingsData? settings,
    int? saveSuccessTick,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      profile: profile ?? this.profile,
      settings: settings ?? this.settings,
      saveSuccessTick: saveSuccessTick ?? this.saveSuccessTick,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSaving,
    profile,
    settings,
    saveSuccessTick,
    errorMessage,
  ];
}
