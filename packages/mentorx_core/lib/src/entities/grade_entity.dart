part of 'package:mentorx_core/mentorx_core.dart';

final class GradeEntity extends Equatable {
  final String id;
  final String name;
  final List<CategoryEntity> categories;

  const GradeEntity({
    required this.id,
    required this.name,
    this.categories = const [],
  });

  static const placeholder = GradeEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name, categories];

  GradeEntity copyWith({
    String? id,
    String? name,
    List<CategoryEntity>? categories,
  }) {
    return GradeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      categories: categories ?? this.categories,
    );
  }
}
