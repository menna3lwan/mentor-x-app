part of '../mentorx_core.dart';

enum CacheRepositoryExceptionCode {
  saveFailed,
  getFailed,
  removeFailed,
  clearFailed,
  initializationFailed,
  saveLocationFailed,
  getLocationsFailed,
  removeLocationFailed,
  clearLocationsFailed,
}

final class CacheRepositoryException
    extends MentorXException<CacheRepositoryExceptionCode> {
  CacheRepositoryException({required super.code, super.message});
}

final class CacheKeys {
  CacheKeys._();

  static const String languageCode = 'languageCode';
  static const String user = 'user';
  static const String brightness = 'brightness';
  static const String accessToken = 'accessToken';
}

abstract interface class CacheRepository {
  Future<void> initialize();

  /// Store a key-value pair in the cache
  Future<void> put(String key, String value);

  /// Retrieve a value by key from the cache
  Future<String?> get(String key);

  /// Check if a key exists in the cache
  Future<bool> containsKey(String key);

  /// Remove a key-value pair from the cache
  Future<void> remove(String key);

  /// Clear all cached data
  Future<void> clear();

  /// Get all keys from the cache
  Future<List<String>> getAllKeys();

  /// Get all key-value pairs from the cache
  Future<Map<String, String>> getAll();

  /// Store multiple key-value pairs at once
  Future<void> putAll(Map<String, String> data);

  /// Remove multiple keys at once
  Future<void> removeAll(List<String> keys);
}
