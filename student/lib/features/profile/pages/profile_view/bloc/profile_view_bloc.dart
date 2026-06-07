import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'profile_view_event.dart';
part 'profile_view_state.dart';

sealed class ProfileViewPresentationEvent {
  const ProfileViewPresentationEvent();
}

final class ProfileViewNavigateBack extends ProfileViewPresentationEvent {
  const ProfileViewNavigateBack();
}

final class ProfileViewBloc extends Bloc<ProfileViewEvent, ProfileViewState>
    with BlocPresentationMixin<ProfileViewState, ProfileViewPresentationEvent> {
  ProfileViewBloc({
    required this.profileRepository,
    required this.analyticsService,
  }) : super(ProfileViewState.initial) {
    on<ProfileViewLoadEvent>(_onLoad);
  }

  final ProfileRepository profileRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    ProfileViewLoadEvent event,
    Emitter<ProfileViewState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.profileViewed);
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
