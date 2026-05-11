
/// An abstract service for tracking analytics events and screen views.
abstract class AnalyticsService {
  /// Initializes the analytics service.
  Future<void> initialize();

  /// Logs a custom event.
  ///
  /// [name] is the name of the event.
  /// [parameters] are the optional parameters to log with the event.
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  });

  /// Sets the current screen name.
  ///
  /// [screenName] is the name of the screen.
  /// [screenClassOverride] is an optional override for the screen class.
  Future<void> setCurrentScreen({
    required String screenName,
    String? screenClassOverride,
  });

  /// Sets the user ID for the current user.
  ///
  /// [id] is the unique identifier for the user.
  Future<void> setUserId(String? id);

  /// Sets a user property.
  ///
  /// [name] is the name of the property.
  /// [value] is the value of the property.
  Future<void> setUserProperty({
    required String name,
    required String? value,
  });

  /// Resets all user data for the current user.
  Future<void> resetAnalyticsData();
}
