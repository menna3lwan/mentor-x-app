part of '../../mentorx_core.dart';

class GovernorateEntity extends Equatable {
  final String id;
  final String name;

  const GovernorateEntity({
    required this.id,
    required this.name,
  });

  static final placeholder = GovernorateEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];
}
