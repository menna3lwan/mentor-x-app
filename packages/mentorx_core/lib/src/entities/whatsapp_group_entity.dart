part of 'package:mentorx_core/mentorx_core.dart';

class WhatsAppGroupEntity extends Equatable {
  final String id;
  final String name;
  final String url;
  final String? description;
  final String? imageUrl;

  const WhatsAppGroupEntity({
    required this.id,
    required this.name,
    required this.url,
    this.description,
    this.imageUrl,
  });

  static const placeholder = WhatsAppGroupEntity(
    id: '',
    name: '',
    url: '',
  );

  @override
  List<Object?> get props => [id, name, url, description, imageUrl];

  WhatsAppGroupEntity copyWith({
    String? id,
    String? name,
    String? url,
    String? description,
    String? imageUrl,
  }) {
    return WhatsAppGroupEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
