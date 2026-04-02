part of '../../mentorx_core.dart';

base class TenantEntity extends Equatable {
  final String id;
  final String name;
  final String? logoUrl;
  final String? whatsappNumber;

  const TenantEntity({
    required this.id,
    required this.name,
    this.logoUrl,
    this.whatsappNumber,
  });


  static final placeholder = TenantEntity(
    id: '',
    name: '',
  );
  @override
  List<Object?> get props => [id, name, logoUrl, whatsappNumber];
}
