import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import '../../../../../core/core.dart';

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
  WhatsappGroupsPageBloc() : super(WhatsappGroupsPageState.initial) {
    on<WhatsappGroupsPageInitialized>(_onInitialized);
    on<WhatsappGroupsPageRefreshed>(_onRefreshed);
    on<WhatsappGroupsPageJoinRequested>(_onJoinRequested);
  }

  Future<void> _onInitialized(
    WhatsappGroupsPageInitialized event,
    Emitter<WhatsappGroupsPageState> emit,
  ) async {
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

    final groups = <WhatsappGroupUiModel>[
      const WhatsappGroupUiModel(
        id: 'math-grade-10',
        title: 'Grade 10 Math Group',
        description: 'Homework reminders, live class updates, and quick Q&A.',
        inviteLink: 'https://chat.whatsapp.com/mock-grade10-math',
        participantsCount: 128,
      ),
      const WhatsappGroupUiModel(
        id: 'science-grade-10',
        title: 'Grade 10 Science Group',
        description: 'Chapter notes, practical tips, and exam review sessions.',
        inviteLink: 'https://chat.whatsapp.com/mock-grade10-science',
        participantsCount: 94,
      ),
      const WhatsappGroupUiModel(
        id: 'announcements-main',
        title: 'Student Announcements',
        description: 'Important center announcements and schedule changes.',
        inviteLink: 'https://chat.whatsapp.com/mock-announcements',
        participantsCount: 460,
      ),
    ];

    emit(
      state.copyWith(
        loadingState: LoadingState.loaded,
        groups: groups,
      ),
    );
  }
}
