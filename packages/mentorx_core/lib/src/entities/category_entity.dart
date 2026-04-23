part of 'package:mentorx_core/mentorx_core.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? gradeId;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.gradeId,
  });

  static const placeholder = CategoryEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name, gradeId];

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? gradeId,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      gradeId: gradeId ?? this.gradeId,
    );
  }
}
