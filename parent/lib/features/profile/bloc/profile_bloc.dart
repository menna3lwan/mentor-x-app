import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'profile_event.dart';
part 'profile_state.dart';

// ──── Presentation events (one-shot side effects) ─────────────────────────

sealed class ProfilePresentationEvent {
  const ProfilePresentationEvent();
}

/// Fired when the profile has been saved (PUT or avatar upload). Wrapper
/// pops the edit screen and shows a success toast.
final class ProfileSavedPresentationEvent extends ProfilePresentationEvent {
  final ParentEntity user;
  const ProfileSavedPresentationEvent({required this.user});
}

/// Fired on any failure path. Carries a kind enum so the UI can pick a
/// localized message without parsing raw strings.
final class ProfileFailurePresentationEvent extends ProfilePresentationEvent {
  final ProfileFailureKind kind;
  final String? rawMessage;
  const ProfileFailurePresentationEvent({
    required this.kind,
    this.rawMessage,
  });
}

/// Fired when the session expires while the user is editing — wrapper
/// bounces them to /login.
final class ProfileUnauthorizedPresentationEvent
    extends ProfilePresentationEvent {
  const ProfileUnauthorizedPresentationEvent();
}

/// Granular kinds the UI can localize. Anything else falls into `unknown`.
enum ProfileFailureKind {
  unknown,
  loadFailed,
  saveFailed,
  uploadFailed,
  invalidImage,
  network,
  unauthorized,
  nameTooShort,
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the parent profile (view + edit). Loads fresh data on start,
/// tracks the working edit form in state, and surfaces save/avatar results
/// as presentation events.
///
/// Concurrency contract:
/// - `ProfileLoadRequested` is restartable: pull-to-refresh always wins.
/// - `ProfileSaveRequested` and `ProfileAvatarSelected` are droppable so a
///   double-tap can't double-fire.
final class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
    with BlocPresentationMixin<ProfileState, ProfilePresentationEvent> {
  final ParentProfileRepository _profileRepository;
  static final MentorXLogger _logger = MentorXLogger('ProfileBloc');

  static const int _minNameLength = 4;

  ProfileBloc({
    required ParentProfileRepository profileRepository,
    ParentEntity? initialProfile,
  }) : _profileRepository = profileRepository,
       super(ProfileState.initial(initialProfile)) {
    on<ProfileLoadRequested>(_onLoadRequested, transformer: restartable());
    on<ProfileNameChanged>(_onNameChanged);
    on<ProfileEditStarted>(_onEditStarted);
    on<ProfileEditCancelled>(_onEditCancelled);
    on<ProfileSaveRequested>(_onSaveRequested, transformer: droppable());
    on<ProfileAvatarSelected>(_onAvatarSelected, transformer: droppable());
  }

  Future<void> _onLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loadStatus: ProfileLoadStatus.loading));
    try {
      final profile = await _profileRepository.getProfile();
      emit(
        state.copyWith(
          loadStatus: ProfileLoadStatus.loaded,
          profile: profile,
          // Seed the edit form whenever we successfully reload so the next
          // edit session starts from the freshest data.
          draftName: profile.fullName,
        ),
      );
    } catch (e, s) {
      _logger.error('Failed to load profile: $e', e, s);
      _emitFailure(
        emit,
        loadStatus: ProfileLoadStatus.failure,
        error: e,
        defaultKind: ProfileFailureKind.loadFailed,
      );
    }
  }

  void _onEditStarted(
    ProfileEditStarted event,
    Emitter<ProfileState> emit,
  ) {
    final profile = state.profile;
    emit(
      state.copyWith(
        draftName: profile?.fullName ?? '',
        saveStatus: ProfileSaveStatus.idle,
        avatarStatus: ProfileSaveStatus.idle,
      ),
    );
  }

  void _onEditCancelled(
    ProfileEditCancelled event,
    Emitter<ProfileState> emit,
  ) {
    final profile = state.profile;
    emit(
      state.copyWith(
        draftName: profile?.fullName ?? '',
        saveStatus: ProfileSaveStatus.idle,
      ),
    );
  }

  void _onNameChanged(
    ProfileNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(draftName: event.name));
  }

  Future<void> _onSaveRequested(
    ProfileSaveRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final trimmed = state.draftName.trim();
    if (trimmed.length < _minNameLength) {
      emitPresentation(
        const ProfileFailurePresentationEvent(
          kind: ProfileFailureKind.nameTooShort,
        ),
      );
      return;
    }

    // No-op short-circuit: if the field hasn't changed, do not call the
    // backend — keeps PUT requests off the wire on idempotent saves.
    final currentName = state.profile?.fullName ?? '';
    if (trimmed == currentName.trim()) {
      emitPresentation(
        ProfileSavedPresentationEvent(user: state.profile!),
      );
      return;
    }

    emit(state.copyWith(saveStatus: ProfileSaveStatus.saving));
    try {
      final updated = await _profileRepository.updateProfile(name: trimmed);
      emit(
        state.copyWith(
          saveStatus: ProfileSaveStatus.success,
          profile: updated,
          draftName: updated.fullName,
        ),
      );
      emitPresentation(ProfileSavedPresentationEvent(user: updated));
    } catch (e, s) {
      _logger.error('Failed to update profile: $e', e, s);
      _emitFailure(
        emit,
        saveStatus: ProfileSaveStatus.failure,
        error: e,
        defaultKind: ProfileFailureKind.saveFailed,
      );
    }
  }

  Future<void> _onAvatarSelected(
    ProfileAvatarSelected event,
    Emitter<ProfileState> emit,
  ) async {
    if (event.imagePath.trim().isEmpty) {
      emitPresentation(
        const ProfileFailurePresentationEvent(
          kind: ProfileFailureKind.invalidImage,
        ),
      );
      return;
    }
    emit(state.copyWith(avatarStatus: ProfileSaveStatus.saving));
    try {
      final updated = await _profileRepository.uploadAvatar(event.imagePath);
      emit(
        state.copyWith(
          avatarStatus: ProfileSaveStatus.success,
          profile: updated,
        ),
      );
      emitPresentation(ProfileSavedPresentationEvent(user: updated));
    } catch (e, s) {
      _logger.error('Failed to upload avatar: $e', e, s);
      _emitFailure(
        emit,
        avatarStatus: ProfileSaveStatus.failure,
        error: e,
        defaultKind: ProfileFailureKind.uploadFailed,
      );
    }
  }

  // ─────────────────────────── Helpers ─────────────────────────────────────

  void _emitFailure(
    Emitter<ProfileState> emit, {
    ProfileLoadStatus? loadStatus,
    ProfileSaveStatus? saveStatus,
    ProfileSaveStatus? avatarStatus,
    required Object error,
    required ProfileFailureKind defaultKind,
  }) {
    emit(
      state.copyWith(
        loadStatus: loadStatus,
        saveStatus: saveStatus,
        avatarStatus: avatarStatus,
        errorMessage: error.describeError(),
      ),
    );
    if (isUnauthorizedError(error)) {
      emitPresentation(const ProfileUnauthorizedPresentationEvent());
      return;
    }
    emitPresentation(
      ProfileFailurePresentationEvent(
        kind: _classifyKind(error, defaultKind),
        rawMessage: error.describeError(),
      ),
    );
  }

  ProfileFailureKind _classifyKind(
    Object error,
    ProfileFailureKind defaultKind,
  ) {
    if (error is ParentProfileRepositoryException) {
      return switch (error.code) {
        ParentProfileRepositoryExceptionCode.invalidImage =>
          ProfileFailureKind.invalidImage,
        ParentProfileRepositoryExceptionCode.networkError =>
          ProfileFailureKind.network,
        ParentProfileRepositoryExceptionCode.unauthorized =>
          ProfileFailureKind.unauthorized,
        ParentProfileRepositoryExceptionCode.failedToLoadProfile =>
          ProfileFailureKind.loadFailed,
        ParentProfileRepositoryExceptionCode.failedToUpdateProfile =>
          ProfileFailureKind.saveFailed,
        ParentProfileRepositoryExceptionCode.failedToUploadAvatar =>
          ProfileFailureKind.uploadFailed,
        ParentProfileRepositoryExceptionCode.unknown => defaultKind,
      };
    }
    return switch (classifyHttpFailure(error)) {
      GenericFailureKind.unauthorized => ProfileFailureKind.unauthorized,
      GenericFailureKind.notFound => defaultKind,
      GenericFailureKind.network => ProfileFailureKind.network,
      GenericFailureKind.unknown => defaultKind,
    };
  }
}
