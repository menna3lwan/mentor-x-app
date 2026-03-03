import 'package:equatable/equatable.dart';

class ParentEntity extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String? profileImageUrl;

  const ParentEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, profileImageUrl];
}
