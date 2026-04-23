part of 'package:mentorx_core/mentorx_core.dart';

class CenterEntity extends Equatable {
  final String id;
  final String name;

  const CenterEntity({
    required this.id,
    required this.name,
  });

  static const placeholder = CenterEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];

  CenterEntity copyWith({
    String? id,
    String? name,
  }) {
    return CenterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
