import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_http_client/dio_http_client.dart';

final class DioParentHomeRepository implements ParentHomeRepository {
  const DioParentHomeRepository({
    required HttpClient httpClient,
    required CacheRepository cacheRepository,
  })  : _httpClient = httpClient,
        _cacheRepository = cacheRepository;

  final HttpClient _httpClient;
  final CacheRepository _cacheRepository;

  @override
  Future<List<({String title, String value, String subtitle, int colorValue, IconData icon})>> getStats() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<List<({String subject, double performance})>> getSubjectPerformance() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<List<({String title, String date, IconData icon})>> getRecentAchievements() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<String> getAiInsight() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
