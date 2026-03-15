import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
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

final class EditProfilePageBloc
    extends Bloc<EditProfilePageEvent, EditProfilePageState>
    with
        BlocPresentationMixin<
          EditProfilePageState,
          EditProfilePagePresentationEvent
        > {
  EditProfilePageBloc({required this.profileRepository})
    : super(EditProfilePageState.initial) {
    on<EditProfilePageLoadEvent>(_onLoad);
  }

  final ProfileRepository profileRepository;

  Future<void> _onLoad(
    EditProfilePageLoadEvent event,
    Emitter<EditProfilePageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
