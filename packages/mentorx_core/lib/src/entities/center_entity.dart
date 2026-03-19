part of '../../mentorx_core.dart';

class CenterEntity extends Equatable {
  final String id;
  final String name;
  final String? address;

  const CenterEntity({
    required this.id,
    required this.name,
    this.address,
  });

  static final placeholder = CenterEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name, address];
}
