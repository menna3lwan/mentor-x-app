part of 'package:mentorx_core/mentorx_core.dart';

base class GovernorateEntity extends Equatable {
  final String id;
  final String name;

  const GovernorateEntity({
    required this.id,
    required this.name,
  });

  static const placeholder = GovernorateEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];

  GovernorateEntity copyWith({
    String? id,
    String? name,
  }) {
    return GovernorateEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
