part of '../../mentorx_core.dart';

class GroupEntity extends Equatable {
  final String id;
  final String name;
  final int? currentSize;
  final int? maxSize;

  const GroupEntity({
    required this.id,
    required this.name,
    this.currentSize,
    this.maxSize,
  });

  static final placeholder = GroupEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name, currentSize, maxSize];
}
