part of 'package:mentorx_core/mentorx_core.dart';

final class AreaEntity extends Equatable {
  final String id;
  final String name;
  final int? displayOrder;

  const AreaEntity({
    required this.id,
    required this.name,
    this.displayOrder,
  });

  @override
  List<Object?> get props => [id, name, displayOrder];

  AreaEntity copyWith({
    String? id,
    String? name,
    int? displayOrder,
  }) {
    return AreaEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }
}
