part of 'package:mentorx_core/mentorx_core.dart';

class DistrictEntity extends Equatable {
  final String id;
  final String name;
  final String governorateId;

  const DistrictEntity({
    required this.id,
    required this.name,
    required this.governorateId,
  });

  static const placeholder = DistrictEntity(
    id: '',
    name: '',
    governorateId: '',
  );

  @override
  List<Object?> get props => [id, name, governorateId];

  DistrictEntity copyWith({
    String? id,
    String? name,
    String? governorateId,
  }) {
    return DistrictEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      governorateId: governorateId ?? this.governorateId,
    );
  }
}
