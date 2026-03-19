import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Performance optimizer for BLoC operations
/// Provides debouncing, caching, and request management utilities
class BlocPerformanceOptimizer {
  // Private constructor for singleton
  BlocPerformanceOptimizer._();
  static final BlocPerformanceOptimizer _instance =
      BlocPerformanceOptimizer._();
  static BlocPerformanceOptimizer get instance => _instance;

  // Cache storage for API responses
  final Map<String, _CacheEntry> _cache = {};

  // Active request tracking for cancellation
  final Map<String, CancelToken> _activeRequests = {};

  // Debounce timers for search operations
  final Map<String, Timer> _debounceTimers = {};

  /// Creates a debounced function that delays execution until after elapsed time
  void debounce(
    String key,
    VoidCallback callback,
    Duration delay,
  ) {
    // Cancel existing timer if present
    _debounceTimers[key]?.cancel();

    // Create new timer
    _debounceTimers[key] = Timer(delay, () {
      callback();
      _debounceTimers.remove(key);
    });
  }

  /// Cached API call with automatic expiration and memory management
  Future<T> cachedApiCall<T>({
    required String cacheKey,
    required Future<T> Function() apiCall,
    Duration cacheDuration = const Duration(minutes: 5),
    bool forceRefresh = false,
  }) async {
    // Check cache for existing entry
    final cacheEntry = _cache[cacheKey];
    if (!forceRefresh &&
        cacheEntry != null &&
        !cacheEntry.isExpired &&
        cacheEntry.data is T) {
      return cacheEntry.data as T;
    }

    // Cancel any existing request for this cache key
    _activeRequests[cacheKey]?.cancel();

    try {
      // Execute API call with cancellation support
      final cancelToken = CancelToken();
      _activeRequests[cacheKey] = cancelToken;

      final result = await apiCall();

      // Cache the result if request wasn't cancelled
      if (!cancelToken.isCancelled) {
        _cache[cacheKey] = _CacheEntry(
          data: result,
          expiry: DateTime.now().add(cacheDuration),
        );
      }

      return result;
    } finally {
      // Clean up active request
      _activeRequests.remove(cacheKey);
    }
  }

  /// Optimized state emission that prevents unnecessary rebuilds
  void optimizedEmit<S>(
    Emitter<S> emit,
    S newState,
    S currentState, {
    bool Function(S current, S next)? shouldEmit,
  }) {
    // Custom comparison function or default equality check
    final shouldEmitState =
        shouldEmit?.call(currentState, newState) ?? (currentState != newState);

    if (shouldEmitState) {
      emit(newState);
    }
  }

  /// Batch multiple state updates to prevent excessive rebuilds
  Future<void> batchStateUpdates<S>(
    Emitter<S> emit,
    S currentState,
    List<S Function(S)> updates, {
    Duration batchDelay = const Duration(milliseconds: 16), // 60fps
  }) async {
    S batchedState = currentState;

    // Apply all updates to the batched state
    for (final update in updates) {
      batchedState = update(batchedState);
    }

    // Wait for next frame to emit batched state
    await Future.delayed(batchDelay);
    emit(batchedState);
  }

  /// Cancels debounce timer for a specific key
  void cancelDebounce(String key) {
    _debounceTimers[key]?.cancel();
    _debounceTimers.remove(key);
  }

  /// Cancels active API request
  void cancelRequest(String key) {
    _activeRequests[key]?.cancel();
    _activeRequests.remove(key);
  }

  /// Clear expired cache entries to free memory
  void cleanExpiredCache() {
    final now = DateTime.now();
    _cache.removeWhere((key, entry) => entry.expiry.isBefore(now));
  }

  /// Clear specific cache entry
  void clearCache(String key) {
    _cache.remove(key);
  }

  /// Clear all cache entries
  void clearAllCache() {
    _cache.clear();
  }

  /// Get cache statistics for debugging/monitoring
  CacheStats getCacheStats() {
    final now = DateTime.now();
    var validEntries = 0;
    var expiredEntries = 0;

    for (final entry in _cache.values) {
      if (entry.expiry.isAfter(now)) {
        validEntries++;
      } else {
        expiredEntries++;
      }
    }

    return CacheStats(
      totalEntries: _cache.length,
      validEntries: validEntries,
      expiredEntries: expiredEntries,
      activeRequests: _activeRequests.length,
      activeDebounceTimers: _debounceTimers.length,
    );
  }
}

/// Internal cache entry structure
class _CacheEntry {
  final dynamic data;
  final DateTime expiry;

  _CacheEntry({required this.data, required this.expiry});

  bool get isExpired => DateTime.now().isAfter(expiry);
}

/// Simple cancellation token for request management
class CancelToken {
  bool _isCancelled = false;

  bool get isCancelled => _isCancelled;

  void cancel() => _isCancelled = true;
}

/// Cache statistics for monitoring performance
class CacheStats {
  final int totalEntries;
  final int validEntries;
  final int expiredEntries;
  final int activeRequests;
  final int activeDebounceTimers;

  const CacheStats({
    required this.totalEntries,
    required this.validEntries,
    required this.expiredEntries,
    required this.activeRequests,
    required this.activeDebounceTimers,
  });

  double get hitRatio {
    if (totalEntries == 0) return 0.0;
    return validEntries / totalEntries;
  }

  @override
  String toString() {
    return 'CacheStats(total: $totalEntries, valid: $validEntries, '
        'expired: $expiredEntries, requests: $activeRequests, '
        'timers: $activeDebounceTimers, hitRatio: ${hitRatio.toStringAsFixed(2)})';
  }
}
