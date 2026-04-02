part of '../../mentorx_core.dart';

/// Rate limiter for authentication endpoints to prevent abuse
/// Implements exponential backoff and per-endpoint tracking
class AuthRateLimiter {
  static final Map<String, _AttemptRecord> _attempts = {};
  static final Map<String, Timer?> _cooldownTimers = {};

  // Configuration
  static const Duration _baseCooldown = Duration(seconds: 30);
  static const Duration _maxCooldown = Duration(minutes: 5);


  /// Checks if an attempt is allowed for the given identifier and endpoint
  /// Returns [RateLimitResult] with attempt status and remaining cooldown
  static RateLimitResult canAttempt(String identifier, String endpoint) {
    final key = '$identifier:$endpoint';
    final record = _attempts[key];

    if (record == null) {
      return const RateLimitResult(canAttempt: true, remainingCooldownMs: 0);
    }

    final now = DateTime.now();
    final timeSinceLastAttempt = now.difference(record.lastAttemptTime);

    // Calculate dynamic cooldown based on consecutive failures
    final cooldownDuration = _calculateCooldown(record.consecutiveFailures);

    if (timeSinceLastAttempt >= cooldownDuration) {
      return const RateLimitResult(canAttempt: true, remainingCooldownMs: 0);
    }

    final remainingCooldown = cooldownDuration - timeSinceLastAttempt;
    return RateLimitResult(
      canAttempt: false,
      remainingCooldownMs: remainingCooldown.inMilliseconds,
    );
  }

  /// Records a failed attempt for the given identifier and endpoint
  static void recordFailedAttempt(String identifier, String endpoint) {
    final key = '$identifier:$endpoint';
    final now = DateTime.now();
    final record = _attempts[key];

    if (record == null) {
      _attempts[key] = _AttemptRecord(
        lastAttemptTime: now,
        consecutiveFailures: 1,
      );
    } else {
      _attempts[key] = _AttemptRecord(
        lastAttemptTime: now,
        consecutiveFailures: record.consecutiveFailures + 1,
      );
    }

    _setCleanupTimer(key);
  }

  /// Records a successful attempt for the given identifier and endpoint
  /// Resets the failure count and removes rate limiting
  static void recordSuccessfulAttempt(String identifier, String endpoint) {
    final key = '$identifier:$endpoint';
    _attempts.remove(key);
    _clearCooldownTimer(key);
  }

  /// Calculates cooldown duration based on consecutive failures
  static Duration _calculateCooldown(int consecutiveFailures) {
    if (consecutiveFailures <= 1) {
      return _baseCooldown;
    }

    // Exponential backoff: 30s, 1m, 2m, 4m, 5m (max)
    final multiplier = (1 << (consecutiveFailures - 1)); // 2^(n-1)
    final cooldownSeconds = (_baseCooldown.inSeconds * multiplier).clamp(
      _baseCooldown.inSeconds,
      _maxCooldown.inSeconds,
    );

    return Duration(seconds: cooldownSeconds);
  }

  /// Sets cleanup timer to remove old attempt records
  static void _setCleanupTimer(String key) {
    _clearCooldownTimer(key);
    _cooldownTimers[key] = Timer(_maxCooldown, () {
      _attempts.remove(key);
      _clearCooldownTimer(key);
    });
  }

  /// Clears existing cooldown timer
  static void _clearCooldownTimer(String key) {
    _cooldownTimers[key]?.cancel();
    _cooldownTimers.remove(key);
  }

  /// Gets remaining cooldown time for debugging/UI feedback
  static Duration? getRemainingCooldown(String identifier, String endpoint) {
    final result = canAttempt(identifier, endpoint);
    if (result.canAttempt) return null;
    return Duration(milliseconds: result.remainingCooldownMs);
  }

  /// Clears all rate limiting data (for testing/logout)
  static void clearAll() {
    for (final timer in _cooldownTimers.values) {
      timer?.cancel();
    }
    _attempts.clear();
    _cooldownTimers.clear();
  }

  /// Gets current failure count for an identifier/endpoint
  static int getFailureCount(String identifier, String endpoint) {
    final key = '$identifier:$endpoint';
    return _attempts[key]?.consecutiveFailures ?? 0;
  }
}

/// Internal record of attempt history
class _AttemptRecord {
  final DateTime lastAttemptTime;
  final int consecutiveFailures;

  const _AttemptRecord({
    required this.lastAttemptTime,
    required this.consecutiveFailures,
  });
}

/// Result of rate limit check
class RateLimitResult {
  final bool canAttempt;
  final int remainingCooldownMs;

  const RateLimitResult({
    required this.canAttempt,
    required this.remainingCooldownMs,
  });

  Duration get remainingCooldown => Duration(milliseconds: remainingCooldownMs);
}

/// Exception thrown when rate limit is exceeded
class RateLimitExceededException implements Exception {
  final String message;
  final Duration remainingCooldown;
  final String identifier;
  final String endpoint;

  const RateLimitExceededException({
    required this.message,
    required this.remainingCooldown,
    required this.identifier,
    required this.endpoint,
  });

  @override
  String toString() =>
      'RateLimitExceededException: $message (cooldown: ${remainingCooldown.inSeconds}s)';
}
