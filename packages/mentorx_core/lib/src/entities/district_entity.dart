part of '../../mentorx_core.dart';

class DistrictEntity extends Equatable {
  final String id;
  final String name;
  final String governorateId;

  const DistrictEntity({
    required this.id,
    required this.name,
    required this.governorateId,
  });

  static final placeholder = DistrictEntity(
    id: '',
    name: '',
    governorateId: '',
  );

  @override
  List<Object?> get props => [id, name, governorateId];
}
