import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'communication_event.dart';
part 'communication_state.dart';

sealed class CommunicationPresentationEvent {
  const CommunicationPresentationEvent();
}

final class CommunicationFailurePresentationEvent
    extends CommunicationPresentationEvent {
  final String message;
  const CommunicationFailurePresentationEvent({required this.message});
}

/// Drives the communication surfaces: announcements archive and WhatsApp group
/// list. Each section loads independently so
/// individual pages can avoid blocking on unrelated data.
final class CommunicationBloc
    extends Bloc<CommunicationEvent, CommunicationState>
    with
        BlocPresentationMixin<
          CommunicationState,
          CommunicationPresentationEvent
        > {
  final ParentCommunicationRepository _repository;

  CommunicationBloc({required ParentCommunicationRepository repository})
    : _repository = repository,
      super(CommunicationState.initial()) {
    on<CommunicationStarted>(_onStarted);
    on<CommunicationRefreshRequested>(_onRefreshRequested);
    on<CommunicationRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    CommunicationStarted event,
    Emitter<CommunicationState> emit,
  ) async {
    if (state.childId == event.childId &&
        (state.announcementsSection.isLoaded ||
            state.announcementsSection.isLoading)) {
      return;
    }
    emit(state.copyWith(childId: event.childId));
    await _loadAll(emit, event.childId);
  }

  Future<void> _onRefreshRequested(
    CommunicationRefreshRequested event,
    Emitter<CommunicationState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, childId: event.childId));
    await _loadAll(emit, event.childId);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _onRetrySection(
    CommunicationRetrySectionRequested event,
    Emitter<CommunicationState> emit,
  ) async {
    final childId = state.childId;
    if (childId == null) return;

    switch (event.section) {
      case CommunicationSection.announcements:
        emit(
          state.copyWith(
            announcementsSection: state.announcementsSection.toLoading(),
          ),
        );
        await _loadAnnouncements(emit, childId);
      case CommunicationSection.whatsAppGroups:
        emit(
          state.copyWith(
            whatsAppGroupsSection: state.whatsAppGroupsSection.toLoading(),
          ),
        );
        await _loadWhatsAppGroups(emit, childId);
    }
  }

  Future<void> _loadAll(
    Emitter<CommunicationState> emit,
    String childId,
  ) async {
    emit(
      state.copyWith(
        announcementsSection: state.announcementsSection.toLoading(),
        whatsAppGroupsSection: state.whatsAppGroupsSection.toLoading(),
      ),
    );

    await Future.wait([
      _loadAnnouncements(emit, childId),
      _loadWhatsAppGroups(emit, childId),
    ]);
  }

  Future<void> _loadAnnouncements(
    Emitter<CommunicationState> emit,
    String childId,
  ) async {
    try {
      final list = await _repository.getAnnouncements(childId);
      emit(
        state.copyWith(
          announcementsSection: CommunicationAsyncSection.loaded(list),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          announcementsSection: CommunicationAsyncSection.failure(e.toString()),
        ),
      );
      emitPresentation(
        CommunicationFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadWhatsAppGroups(
    Emitter<CommunicationState> emit,
    String childId,
  ) async {
    try {
      final list = await _repository.getWhatsAppGroups(childId);
      emit(
        state.copyWith(
          whatsAppGroupsSection: CommunicationAsyncSection.loaded(list),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          whatsAppGroupsSection: CommunicationAsyncSection.failure(
            e.toString(),
          ),
        ),
      );
      emitPresentation(
        CommunicationFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
