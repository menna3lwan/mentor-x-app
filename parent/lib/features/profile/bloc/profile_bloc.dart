import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';

part 'profile_event.dart';
part 'profile_state.dart';

final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('ProfileBloc');

  ProfileBloc({required AnalyticsService analyticsService})
    : _analyticsService = analyticsService,
      super(const ProfileState()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileSettingsUpdated>(_onSettingsUpdated);
  }

  Future<void> _onStarted(ProfileStarted event, Emitter<ProfileState> emit) async {
    _logger.info('ProfileStarted event received');
    emit(state.copyWith(status: ProfileStatus.loading));
    _analyticsService.logEvent(name: AnalyticsEvents.profileViewed);
    try {
      // Mocking parent profile data for now
      // In a real app, this would come from an AuthenticationRepository or ProfileRepository
      final mockParent = ParentEntity(
        id: 'parent_1',
        firstName: 'Parent',
        lastName: 'User',
        email: 'parent@user.com',
        phoneNumber: '+1234567890',
        status: ParentStatus.active,
        createdAt: DateTime(2023),
        updatedAt: DateTime(2023),
      );
      _logger.info('Successfully loaded mock parent profile');
      emit(state.copyWith(status: ProfileStatus.success, profileData: mockParent));
    } catch (e, s) {
      _logger.error('Failed to load parent profile', e, s);
      emit(state.copyWith(status: ProfileStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onSettingsUpdated(ProfileSettingsUpdated event, Emitter<ProfileState> emit) async {
    _logger.info('ProfileSettingsUpdated event received: ${event.settings}');
    // Handle settings update
  }
}
