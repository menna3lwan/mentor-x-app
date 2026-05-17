import 'package:bloc/bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'profile_event.dart';
part 'profile_state.dart';

/// Lightweight bloc kept as a placeholder for future profile-mutation flows
/// (e.g. edit profile, change avatar). The parent profile page itself reads
/// the authenticated user directly from `AppAuthenticationCubit`, so this
/// bloc is currently a no-op except for compatibility with any
/// import-site that referenced the old API.
final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileSettingsUpdated>(_onSettingsUpdated);
  }

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    // Intentionally no-op: profile data is owned by AppAuthenticationCubit.
  }

  Future<void> _onSettingsUpdated(
    ProfileSettingsUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    // Reserved for future settings persistence work.
  }
}
