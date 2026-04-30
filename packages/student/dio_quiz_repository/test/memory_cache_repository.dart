import 'package:mentorx_core/mentorx_core.dart';

final class MemoryCacheRepository implements CacheRepository {
  final Map<String, String> _data = {};

  @override
  Future<void> initialize() async {}

  @override
  Future<void> put(String key, String value) async {
    _data[key] = value;
  }

  @override
  Future<String?> get(String key) async {
    return _data[key];
  }

  @override
  Future<bool> containsKey(String key) async {
    return _data.containsKey(key);
  }

  @override
  Future<void> remove(String key) async {
    _data.remove(key);
  }

  @override
  Future<void> clear() async {
    _data.clear();
  }

  @override
  Future<List<String>> getAllKeys() async {
    return _data.keys.toList();
  }

  @override
  Future<Map<String, String>> getAll() async {
    return Map<String, String>.from(_data);
  }

  @override
  Future<void> putAll(Map<String, String> data) async {
    _data.addAll(data);
  }

  @override
  Future<void> removeAll(List<String> keys) async {
    for (final key in keys) {
      _data.remove(key);
    }
  }
}
