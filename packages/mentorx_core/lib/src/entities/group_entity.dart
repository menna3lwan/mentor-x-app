part of 'package:mentorx_core/mentorx_core.dart';

base class GroupEntity extends Equatable {
  final String id;
  final String name;

  const GroupEntity({
    required this.id,
    required this.name,
  });

  static const placeholder = GroupEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];

  GroupEntity copyWith({
    String? id,
    String? name,
  }) {
    return GroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
