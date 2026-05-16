part of 'package:mentorx_core/mentorx_core.dart';

class LevelEntity extends Equatable {
  final String id;
  final String name;
  final int? orderNumber;

  const LevelEntity({
    required this.id,
    required this.name,
    this.orderNumber,
  });

  @override
  List<Object?> get props => [id, name, orderNumber];

  LevelEntity copyWith({
    String? id,
    String? name,
    int? orderNumber,
  }) {
    return LevelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      orderNumber: orderNumber ?? this.orderNumber,
    );
  }
}
