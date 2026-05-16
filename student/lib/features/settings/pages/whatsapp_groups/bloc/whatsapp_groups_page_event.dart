part of 'whatsapp_groups_page_bloc.dart';

sealed class WhatsappGroupsPageEvent extends Equatable {
  const WhatsappGroupsPageEvent();

  @override
  List<Object?> get props => [];
}

final class WhatsappGroupsPageInitialized extends WhatsappGroupsPageEvent {
  const WhatsappGroupsPageInitialized();
}

final class WhatsappGroupsPageRefreshed extends WhatsappGroupsPageEvent {
  const WhatsappGroupsPageRefreshed();
}

final class WhatsappGroupsPageJoinRequested extends WhatsappGroupsPageEvent {
  final String groupId;

  const WhatsappGroupsPageJoinRequested({required this.groupId});

  @override
  List<Object?> get props => [groupId];
}
