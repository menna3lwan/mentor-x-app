import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

sealed class ChangePasswordPresentationEvent {
  const ChangePasswordPresentationEvent();
}

final class ChangePasswordNavigateBack extends ChangePasswordPresentationEvent {
  const ChangePasswordNavigateBack();
}

final class ChangePasswordSuccess extends ChangePasswordPresentationEvent {
  const ChangePasswordSuccess();
}

final class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState>
    with BlocPresentationMixin<ChangePasswordState, ChangePasswordPresentationEvent> {
  ChangePasswordBloc({
    required this.profileRepository,
    required this.analyticsService,
  }) : super(ChangePasswordState.initial) {
    on<ChangePasswordLoadEvent>(_onLoad);
    on<ChangePasswordSubmitEvent>(_onSubmit);
  }

  final ProfileRepository profileRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    ChangePasswordLoadEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.changePasswordViewed);
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmit(
    ChangePasswordSubmitEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        errorMessage: const MentorXNullableValue(null),
      ),
    );

    try {
      await profileRepository.changePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      analyticsService.logEvent(name: AnalyticsEvents.passwordChanged);
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(const ChangePasswordSuccess());
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
