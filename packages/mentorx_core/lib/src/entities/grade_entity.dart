part of 'package:mentorx_core/mentorx_core.dart';

class GradeEntity extends Equatable {
  final String id;
  final String name;

  const GradeEntity({
    required this.id,
    required this.name,
  });

  static const placeholder = GradeEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];

  GradeEntity copyWith({
    String? id,
    String? name,
  }) {
    return GradeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
