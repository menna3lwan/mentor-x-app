import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'announcements_state.dart';

final class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  final StudentHomeRepository _homeRepository;

  AnnouncementsCubit({required StudentHomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const AnnouncementsInitial());

  Future<void> loadAnnouncements() async {
    emit(const AnnouncementsLoading());
    try {
      final announcements = await _homeRepository.getRecentAnnouncements(size: 20);
      emit(AnnouncementsLoaded(announcements: announcements));
    } catch (e) {
      emit(AnnouncementsFailure(message: e.toString()));
    }
  }
}
