part of '../../mentorx_core.dart';

final class GradeEntity extends Equatable {
  final String id;
  final String name;

  const GradeEntity({
    required this.id,
    required this.name,
  });


  static final placeholder = GradeEntity(
    id: '',
    name: '',
  );
  @override
  List<Object?> get props => [id, name];
}
