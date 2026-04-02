part of '../../mentorx_core.dart';

base class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? gradeId;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.gradeId,
  });


  static final placeholder = CategoryEntity(
    id: '',
    name: '',
  );
  @override
  List<Object?> get props => [id, name, gradeId];
}
