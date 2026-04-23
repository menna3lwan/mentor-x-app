part of 'package:mentorx_core/mentorx_core.dart';

class WhatsAppGroupEntity extends Equatable {
  final String id;
  final String name;
  final String url;
  final String? description;

  const WhatsAppGroupEntity({
    required this.id,
    required this.name,
    required this.url,
    this.description,
  });

  static const placeholder = WhatsAppGroupEntity(
    id: '',
    name: '',
    url: '',
  );

  @override
  List<Object?> get props => [id, name, url, description];

  WhatsAppGroupEntity copyWith({
    String? id,
    String? name,
    String? url,
    String? description,
  }) {
    return WhatsAppGroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      description: description ?? this.description,
    );
  }
}
