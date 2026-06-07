import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/app/student_app.dart';
import 'package:mentorx_student/core/core.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

sealed class EditProfilePresentationEvent {
  const EditProfilePresentationEvent();
}

final class EditProfileNavigateBack extends EditProfilePresentationEvent {
  const EditProfileNavigateBack();
}

final class EditProfileSuccess extends EditProfilePresentationEvent {
  const EditProfileSuccess();
}

final class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState>
    with BlocPresentationMixin<EditProfileState, EditProfilePresentationEvent> {
  static final MentorXLogger _logger = MentorXLogger('EditProfileBloc');

  EditProfileBloc({
    required this.profileRepository,
    required this.analyticsService,
  }) : super(EditProfileState.initial) {
    on<EditProfileLoadEvent>(_onLoad);
    on<EditProfileSubmitRequestEvent>(_onSubmitRequest);
    on<EditProfileUpdateProfileEvent>(_onUpdateProfile);
  }

  final ProfileRepository profileRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    EditProfileLoadEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    _logger.info('_onLoad entered');
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmitRequest(
    EditProfileSubmitRequestEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    _logger.info('_onSubmitRequest entered');
    if (profileRepository is! StudentProfileRepository) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: const MentorXNullableValue('Invalid repository type'),
        ),
      );
      emitPresentation(const EditProfileNavigateBack());
      return;
    }

    final studentRepo = profileRepository as StudentProfileRepository;

    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: const MentorXNullableValue(null),
      ),
    );

    try {
      await studentRepo.submitEditRequest(
        fieldName: event.fieldName,
        oldValue: event.oldValue,
        newValue: event.newValue,
        reason: event.reason,
      );
      
      // Refetch profile and update state using event bus
      try {
        final updatedProfile = await profileRepository.getProfile();
        appEventBus.fire(AppAuthenticationUpdateEvent(user: updatedProfile));
      } catch (e) {
        // Silently fail
      }

      emit(state.copyWith(loadingState: LoadingState.loaded));
      analyticsService.logEvent(
        name: AnalyticsEvents.profileEditRequested,
        parameters: {
          AnalyticsParams.fieldName: event.fieldName,
        },
      );
      emitPresentation(const EditProfileSuccess());
    } on MentorXException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.toString()),
        ),
      );
    }
  }

  Future<void> _onUpdateProfile(
    EditProfileUpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    _logger.info('_onUpdateProfile entered');
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: const MentorXNullableValue(null),
      ),
    );

    try {
      final updatedProfile = await profileRepository.updateProfile(event.updatedUser);
      
      // Update state using event bus
      appEventBus.fire(AppAuthenticationUpdateEvent(user: updatedProfile));

      emit(state.copyWith(loadingState: LoadingState.loaded));
      analyticsService.logEvent(
        name: AnalyticsEvents.profileEditRequested,
        parameters: {
          'batch_update': true,
        },
      );
      emitPresentation(const EditProfileSuccess());
    } on MentorXException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.message),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.toString()),
        ),
      );
    }
  }
}
