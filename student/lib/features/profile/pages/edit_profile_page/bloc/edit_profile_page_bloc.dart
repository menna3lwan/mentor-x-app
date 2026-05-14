import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'edit_profile_page_event.dart';
part 'edit_profile_page_state.dart';

sealed class EditProfilePagePresentationEvent {
  const EditProfilePagePresentationEvent();
}

final class EditProfilePageNavigateBack
    extends EditProfilePagePresentationEvent {
  const EditProfilePageNavigateBack();
}

final class EditProfilePageSuccess extends EditProfilePagePresentationEvent {
  const EditProfilePageSuccess();
}

final class EditProfilePageBloc
    extends Bloc<EditProfilePageEvent, EditProfilePageState>
    with
        BlocPresentationMixin<
          EditProfilePageState,
          EditProfilePagePresentationEvent
        > {
  EditProfilePageBloc({
    required this.profileRepository,
    required this.analyticsService,
  }) : super(EditProfilePageState.initial) {
    on<EditProfilePageLoadEvent>(_onLoad);
    on<EditProfilePageSubmitRequestEvent>(_onSubmitRequest);
  }

  final ProfileRepository profileRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    EditProfilePageLoadEvent event,
    Emitter<EditProfilePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }

  Future<void> _onSubmitRequest(
    EditProfilePageSubmitRequestEvent event,
    Emitter<EditProfilePageState> emit,
  ) async {
    if (profileRepository is! StudentProfileRepository) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: const MentorXNullableValue('Invalid repository type'),
        ),
      );
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
      emit(state.copyWith(loadingState: LoadingState.loaded));
      analyticsService.logEvent(
        name: AnalyticsEvents.profileEditRequested,
        parameters: {
          AnalyticsParams.fieldName: event.fieldName,
        },
      );
      emitPresentation(const EditProfilePageSuccess());
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
