import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'change_password_page_event.dart';
part 'change_password_page_state.dart';

sealed class ChangePasswordPagePresentationEvent {
  const ChangePasswordPagePresentationEvent();
}

final class ChangePasswordPageNavigateBack
    extends ChangePasswordPagePresentationEvent {
  const ChangePasswordPageNavigateBack();
}

final class ChangePasswordPageSuccess
    extends ChangePasswordPagePresentationEvent {
  const ChangePasswordPageSuccess();
}

final class ChangePasswordPageBloc
    extends Bloc<ChangePasswordPageEvent, ChangePasswordPageState>
    with
        BlocPresentationMixin<
          ChangePasswordPageState,
          ChangePasswordPagePresentationEvent
        > {
  ChangePasswordPageBloc({required this.profileRepository})
    : super(ChangePasswordPageState.initial) {
    on<ChangePasswordPageLoadEvent>(_onLoad);
    on<ChangePasswordPageSubmitEvent>(_onSubmit);
  }

  final ProfileRepository profileRepository;

  Future<void> _onLoad(
    ChangePasswordPageLoadEvent event,
    Emitter<ChangePasswordPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmit(
    ChangePasswordPageSubmitEvent event,
    Emitter<ChangePasswordPageState> emit,
  ) async {
    emit(state.copyWith(
      loadingState: LoadingState.loading,
      errorMessage: const MentorXNullableValue(null),
    ));

    try {
      await profileRepository.changePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(const ChangePasswordPageSuccess());
    } on MentorXException catch (e) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: MentorXNullableValue(e.message),
      ));
    } catch (e) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: MentorXNullableValue(e.toString()),
      ));
    }
  }
}
