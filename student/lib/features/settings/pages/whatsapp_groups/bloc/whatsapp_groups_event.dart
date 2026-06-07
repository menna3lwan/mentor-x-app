part of 'whatsapp_groups_bloc.dart';

sealed class WhatsappGroupsEvent extends Equatable {
  const WhatsappGroupsEvent();

  @override
  List<Object?> get props => [];
}

final class WhatsappGroupsInitialized extends WhatsappGroupsEvent {
  const WhatsappGroupsInitialized();
}

final class WhatsappGroupsRefreshed extends WhatsappGroupsEvent {
  const WhatsappGroupsRefreshed();
}

final class WhatsappGroupsJoinRequested extends WhatsappGroupsEvent {
  final String groupId;

  const WhatsappGroupsJoinRequested({required this.groupId});

  @override
  List<Object?> get props => [groupId];
}
