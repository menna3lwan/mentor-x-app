import 'package:mentorx_core/mentorx_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Implementation of CacheRepository using Flutter Secure Storage
class FlutterSecureStorageCacheRepository implements CacheRepository {
  final FlutterSecureStorage _storage;

  FlutterSecureStorageCacheRepository({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> put(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  @override
  Future<List<String>> getAllKeys() async {
    final all = await _storage.readAll();
    return all.keys.toList();
  }

  @override
  Future<Map<String, String>> getAll() async {
    return await _storage.readAll();
  }

  @override
  Future<void> putAll(Map<String, String> data) async {
    for (final entry in data.entries) {
      await _storage.write(key: entry.key, value: entry.value);
    }
  }

  @override
  Future<void> removeAll(List<String> keys) async {
    for (final key in keys) {
      await _storage.delete(key: key);
    }
  }
}
