part of 'whatsapp_groups_bloc.dart';

final class WhatsappGroupUiModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String inviteLink;
  final int participantsCount;
  final String? iconUrl;

  const WhatsappGroupUiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.inviteLink,
    required this.participantsCount,
    this.iconUrl,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    inviteLink,
    participantsCount,
    iconUrl,
  ];
}

final class WhatsappGroupsState extends Equatable {
  final LoadingState loadingState;
  final List<WhatsappGroupUiModel> groups;
  final String? joinedGroupId;

  const WhatsappGroupsState({
    required this.loadingState,
    required this.groups,
    this.joinedGroupId,
  });

  static const initial = WhatsappGroupsState(
    loadingState: LoadingState.initial,
    groups: <WhatsappGroupUiModel>[],
  );

  WhatsappGroupsState copyWith({
    LoadingState? loadingState,
    List<WhatsappGroupUiModel>? groups,
    String? joinedGroupId,
  }) {
    return WhatsappGroupsState(
      loadingState: loadingState ?? this.loadingState,
      groups: groups ?? this.groups,
      joinedGroupId: joinedGroupId ?? this.joinedGroupId,
    );
  }

  bool get isLoading =>
      loadingState.isLoading || loadingState == LoadingState.initial;

  @override
  List<Object?> get props => [loadingState, groups, joinedGroupId];
}
