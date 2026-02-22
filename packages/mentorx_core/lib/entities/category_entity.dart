part of '../mentorx_core.dart';

final class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? gradeId;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.gradeId,
  });

  @override
  List<Object?> get props => [id, name, gradeId];
}
