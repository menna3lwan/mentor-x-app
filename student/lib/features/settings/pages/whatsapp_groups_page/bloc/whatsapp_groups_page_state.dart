part of 'whatsapp_groups_page_bloc.dart';

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

final class WhatsappGroupsPageState extends Equatable {
  final LoadingState loadingState;
  final List<WhatsappGroupUiModel> groups;
  final String? joinedGroupId;

  const WhatsappGroupsPageState({
    required this.loadingState,
    required this.groups,
    this.joinedGroupId,
  });

  static const initial = WhatsappGroupsPageState(
    loadingState: LoadingState.initial,
    groups: <WhatsappGroupUiModel>[],
  );

  WhatsappGroupsPageState copyWith({
    LoadingState? loadingState,
    List<WhatsappGroupUiModel>? groups,
    String? joinedGroupId,
  }) {
    return WhatsappGroupsPageState(
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
