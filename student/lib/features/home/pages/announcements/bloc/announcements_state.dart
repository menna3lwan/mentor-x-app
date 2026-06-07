part of 'announcements_bloc.dart';

final class AnnouncementsState extends Equatable {
  final LoadingState loadingState;
  final List<AnnouncementEntity> announcements;
  final String? errorMessage;

  const AnnouncementsState({
    required this.loadingState,
    required this.announcements,
    this.errorMessage,
  });

  static const initial = AnnouncementsState(
    loadingState: LoadingState.initial,
    announcements: [],
  );

  AnnouncementsState copyWith({
    LoadingState? loadingState,
    List<AnnouncementEntity>? announcements,
    String? errorMessage,
  }) {
    return AnnouncementsState(
      loadingState: loadingState ?? this.loadingState,
      announcements: announcements ?? this.announcements,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [loadingState, announcements, errorMessage];
}
