import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';

part 'leaderboard_page_event.dart';
part 'leaderboard_page_state.dart';

final class LeaderboardPageBloc
    extends Bloc<LeaderboardPageEvent, LeaderboardPageState> {
  final LeaderboardRepository _leaderboardRepository;
  final CourseRepository _courseRepository;

  LeaderboardPageBloc({
    required LeaderboardRepository leaderboardRepository,
    required CourseRepository courseRepository,
  }) : _leaderboardRepository = leaderboardRepository,
       _courseRepository = courseRepository,
       super(const LeaderboardPageState()) {
    on<LeaderboardPageLoadRequested>(_onLoadRequested);
    on<LeaderboardPageFilterChanged>(_onFilterChanged);
  }

  Future<void> _onLoadRequested(
    LeaderboardPageLoadRequested event,
    Emitter<LeaderboardPageState> emit,
  ) async {
    emit(
      state.copyWith(
        loadingState: LoadingState.loading,
        selectedCourseId: event.courseId,
      ),
    );

    try {
      final courses = await _courseRepository.getEnrolledCourses();

      final List<LeaderboardEntryEntity> leaderboard;
      if (event.courseId == null) {
        leaderboard = await _leaderboardRepository.getGlobalLeaderboard();
      } else {
        leaderboard = await _leaderboardRepository.getCourseLeaderboard(
          event.courseId!,
        );
      }

      // Find my rank in the list or fetch it if not present (mocking this logic for now)
      // In a real app, the API might return my rank separately or as part of the list.
      final myRank = leaderboard.isEmpty
          ? null
          : leaderboard.firstWhere(
              (e) =>
                  e.rank >
                  10, // Mock condition to find "me" if I'm not in top 10
              orElse: () => leaderboard.first,
            );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          leaderboard: leaderboard,
          myRank: myRank,
          courses: courses,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFilterChanged(
    LeaderboardPageFilterChanged event,
    Emitter<LeaderboardPageState> emit,
  ) async {
    add(LeaderboardPageLoadRequested(courseId: event.courseId));
  }
}
