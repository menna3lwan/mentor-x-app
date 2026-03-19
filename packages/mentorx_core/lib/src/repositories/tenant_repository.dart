part of '../../mentorx_core.dart';

enum TenantRepositoryExceptionCode {
  unknown,
  failedToLoadGrades,
  failedToLoadCenters,
  failedToLoadSchedules,
  failedToLoadGroups,
  failedToLoadGovernorates,
  failedToLoadDistricts,
}

final class TenantRepositoryException
    extends MentorXException<TenantRepositoryExceptionCode> {
  TenantRepositoryException({required super.code, super.message});
}

abstract interface class TenantRepository {
  Future<void> initialize();
  /// Fetch grades for a tenant.
  Future<List<GradeEntity>> getGrades(String tenantId);

  /// Fetch governorates.
  Future<List<({String id, String name})>> getGovernorates();

  /// Fetch districts by governorate.
  Future<List<({String id, String name})>> getDistricts(String governorateId);
}
