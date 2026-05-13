import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'profile_view_page_event.dart';
part 'profile_view_page_state.dart';

sealed class ProfileViewPagePresentationEvent {
  const ProfileViewPagePresentationEvent();
}

final class ProfileViewPageNavigateBack
    extends ProfileViewPagePresentationEvent {
  const ProfileViewPageNavigateBack();
}

final class ProfileViewPageBloc
    extends Bloc<ProfileViewPageEvent, ProfileViewPageState>
    with
        BlocPresentationMixin<
          ProfileViewPageState,
          ProfileViewPagePresentationEvent
        > {
  ProfileViewPageBloc({
    required this.profileRepository,
    required this.analyticsService,
  }) : super(ProfileViewPageState.initial) {
    on<ProfileViewPageLoadEvent>(_onLoad);
  }

  final ProfileRepository profileRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    ProfileViewPageLoadEvent event,
    Emitter<ProfileViewPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.profileViewed);
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
