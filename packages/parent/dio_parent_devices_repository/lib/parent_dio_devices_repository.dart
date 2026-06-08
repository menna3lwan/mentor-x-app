import 'package:mentorx_core/mentorx_core.dart';

import 'models/device_models.dart';

export 'models/device_models.dart';

/// Dio-backed implementation of [ParentDevicesRepository].
///
/// Backend contract (EduCore Postman):
/// - `GET  /api/auth/session-status` — varies between (a) a list of device
///   records under `data.content` and (b) a single-session payload
///   (`hasSession`, `studentCode`, `role`, …) when the backend hasn't been
///   upgraded to multi-session reporting yet. Both shapes are parsed.
/// - `POST /api/auth/force-logout-all` — revokes every session except the
///   caller's.
/// - `DELETE /api/auth/devices/{id}` — per-device revoke, not declared in
///   Postman; treated as best-effort.
final class DioParentDevicesRepository
    extends HttpClientRepository<ParentDevicesRepositoryExceptionCode>
    implements ParentDevicesRepository {
  final HttpClient _httpClient;

  DioParentDevicesRepository({required HttpClient httpClient})
    : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentDevicesRepositoryExceptionCode code, {
    String? message,
  }) => throw ParentDevicesRepositoryException(code: code, message: message);

  @override
  Future<List<DeviceEntity>> getDevices() async {
    try {
      final response = await _httpClient.get('/api/auth/session-status');
      return _parseDevices(response.data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <DeviceEntity>[];
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentDevicesRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  @override
  Future<List<DeviceEntity>> forceLogoutAll() async {
    try {
      await _httpClient.post('/api/auth/force-logout-all');
      // Re-fetch so the caller sees the post-revoke state.
      return getDevices();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentDevicesRepositoryExceptionCode.forceLogoutFailed,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  @override
  Future<void> deactivateDevice(String deviceId) async {
    try {
      await _httpClient.delete('/api/auth/devices/$deviceId');
    } on HttpClientResponse catch (e) {
      // API-CONTRACT: per-device revoke is not declared in Postman. Treat
      // 404/405 as a no-op so the UI can keep showing the device or refresh
      // its list without crashing.
      if (e.statusCode == 404 || e.statusCode == 405) return;
      handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentDevicesRepositoryExceptionCode.deactivateFailed,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  // ─────────────────────── Helpers ─────────────────────────────────────

  /// Handles both backend shapes for session-status:
  ///   1) `{success, data: { content: [ {…device…} ] }}` (modern, multi-device)
  ///   2) `{role, studentCode, hasSession, redirectTo, message, status}`
  ///      (legacy single-session shape — synthesised into a one-row list).
  List<DeviceEntity> _parseDevices(dynamic raw) {
    final root = asMap(raw);

    // Legacy single-session payload.
    if (root.containsKey('hasSession')) {
      final hasSession = boolOrFalse(root['hasSession']);
      if (!hasSession) return const <DeviceEntity>[];
      return [
        DeviceEntity(
          id: stringOrNull(root['studentCode']) ?? 'current',
          deviceName: stringOrNull(root['message']) ?? 'Active Session',
          deviceModel: stringOrNull(root['role']) ?? 'Parent',
          isActive: true,
          lastUsedAt: DateTime.now(),
        ),
      ];
    }

    // Modern envelope.
    final payload = root['data'] ?? raw;
    final items = payload is Map
        ? asList(payload['content'] ?? payload['devices'])
        : asList(payload);
    return items
        .map(asMap)
        .map(DeviceModel.fromJson)
        .toList(growable: false);
  }

  ParentDevicesRepositoryExceptionCode _classifyStatus(int statusCode) {
    return switch (statusCode) {
      401 || 403 => ParentDevicesRepositoryExceptionCode.unauthorized,
      404 => ParentDevicesRepositoryExceptionCode.notFound,
      _ => ParentDevicesRepositoryExceptionCode.unknown,
    };
  }
}
