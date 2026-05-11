part of 'package:mentorx_core/mentorx_core.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? gradeId;
  final String? levelId;
  final double? price;
  final bool active;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.gradeId,
    this.levelId,
    this.price,
    this.active = true,
    this.createdAt,
    this.updatedAt,
  });

  static const placeholder = CategoryEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        gradeId,
        levelId,
        price,
        active,
        createdAt,
        updatedAt,
      ];

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? gradeId,
    String? levelId,
    double? price,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      gradeId: gradeId ?? this.gradeId,
      levelId: levelId ?? this.levelId,
      price: price ?? this.price,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
