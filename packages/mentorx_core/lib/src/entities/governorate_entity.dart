part of 'package:mentorx_core/mentorx_core.dart';

final class GovernorateEntity extends Equatable {
  final String id;
  final String name;
  final List<AreaEntity> areas;

  const GovernorateEntity({
    required this.id,
    required this.name,
    this.areas = const [],
  });

  static const placeholder = GovernorateEntity(
    id: '',
    name: '',
    areas: [],
  );

  @override
  List<Object?> get props => [id, name, areas];

  GovernorateEntity copyWith({
    String? id,
    String? name,
    List<AreaEntity>? areas,
  }) {
    return GovernorateEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      areas: areas ?? this.areas,
    );
  }
}
