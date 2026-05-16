import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'whatsapp_groups_page_event.dart';
part 'whatsapp_groups_page_state.dart';

sealed class WhatsappGroupsPagePresentationEvent {
  const WhatsappGroupsPagePresentationEvent();
}

final class WhatsappGroupsPageJoinSuccessPresentationEvent
    extends WhatsappGroupsPagePresentationEvent {
  final String message;

  const WhatsappGroupsPageJoinSuccessPresentationEvent({required this.message});
}

final class WhatsappGroupsPageBloc
    extends Bloc<WhatsappGroupsPageEvent, WhatsappGroupsPageState>
    with
        BlocPresentationMixin<
          WhatsappGroupsPageState,
          WhatsappGroupsPagePresentationEvent
        > {
  final StudentCommunicationRepository _repository;
  final AnalyticsService _analyticsService;

  WhatsappGroupsPageBloc({
    required StudentCommunicationRepository repository,
    required AnalyticsService analyticsService,
  }) : _repository = repository,
       _analyticsService = analyticsService,
       super(WhatsappGroupsPageState.initial) {
    on<WhatsappGroupsPageInitialized>(_onInitialized);
    on<WhatsappGroupsPageRefreshed>(_onRefreshed);
    on<WhatsappGroupsPageJoinRequested>(_onJoinRequested);
  }

  Future<void> _onInitialized(
    WhatsappGroupsPageInitialized event,
    Emitter<WhatsappGroupsPageState> emit,
  ) async {
    await _analyticsService.logEvent(name: AnalyticsEvents.whatsappGroupsViewed);
    await _load(emit);
  }

  Future<void> _onRefreshed(
    WhatsappGroupsPageRefreshed event,
    Emitter<WhatsappGroupsPageState> emit,
  ) async {
    await _load(emit);
  }

  Future<void> _onJoinRequested(
    WhatsappGroupsPageJoinRequested event,
    Emitter<WhatsappGroupsPageState> emit,
  ) async {
    final groupName = state.groups
        .firstWhere((group) => group.id == event.groupId,
            orElse: () => const WhatsappGroupUiModel(
                id: '',
                title: 'Unknown',
                description: '',
                inviteLink: '',
                participantsCount: 0,
                iconUrl: ''))
        .title;

    await _analyticsService.logEvent(
      name: AnalyticsEvents.whatsappGroupJoined,
      parameters: {
        AnalyticsParams.name: groupName,
      },
    );

    emit(state.copyWith(joinedGroupId: event.groupId));
    emitPresentation(
      const WhatsappGroupsPageJoinSuccessPresentationEvent(
        message:
            'Invite link copied. Open WhatsApp and paste the invite link to join.',
      ),
    );
  }

  Future<void> _load(Emitter<WhatsappGroupsPageState> emit) async {
    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      final entities = await _repository.getWhatsAppGroups();
      
      final groups = entities.map((entity) => WhatsappGroupUiModel(
        id: entity.id,
        title: entity.name,
        description: entity.description ?? '',
        inviteLink: entity.url,
        participantsCount: 0, // Not provided by the current entity
        iconUrl: entity.imageUrl,
      )).toList();

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          groups: groups,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
