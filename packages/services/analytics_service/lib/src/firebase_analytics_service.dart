import 'package:firebase_analytics/firebase_analytics.dart';
import 'analytics_service.dart';

/// An implementation of [AnalyticsService] using Firebase Analytics.
class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalyticsService({FirebaseAnalytics? analytics})
    : _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  @override
  Future<void> initialize() async {
    // Firebase Analytics is usually initialized via Firebase.initializeApp()
    // but we can ensure collection is enabled here.
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) async {
    final Map<String, Object>? params = parameters?.map(
      (key, value) => MapEntry(key, value ?? ''),
    );
    await _analytics.logEvent(name: name, parameters: params);
  }

  @override
  Future<void> setCurrentScreen({
    required String screenName,
    String? screenClassOverride,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClassOverride,
    );
  }

  @override
  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id: id);
  }

  @override
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> resetAnalyticsData() async {
    await _analytics.resetAnalyticsData();
  }

  /// Returns the observer for Firebase Analytics.
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);
}
