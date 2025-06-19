import 'dart:async';
import 'dart:convert';

import 'package:doculode/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A generic cache manager that provides both in-memory and persistent caching capabilities.
/// 
/// This class handles caching of data with configurable expiration times and supports
/// both in-memory caching for fast access and persistent caching using SharedPreferences
/// for data that needs to survive app restarts.
class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, _CacheEntry> _memoryCache = {};
  SharedPreferences? _prefs;
  bool _initialized = false;

  /// Initialize the cache manager by setting up SharedPreferences
  Future<void> init() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
    log('CacheManager initialized');
  }

  /// Get a value from cache (memory first, then persistent)
  Future<T?> get<T>(String key, {Duration? maxAge}) async {
    if (!_initialized) await init();

    // Check memory cache first
    if (_memoryCache.containsKey(key)) {
      final entry = _memoryCache[key]!;
      if (!entry.isExpired(maxAge)) {
        log('Cache hit (memory): $key');
        return entry.value as T?;
      } else {
        // Remove expired entry
        _memoryCache.remove(key);
        log('Cache expired (memory): $key');
      }
    }

    // Check persistent cache
    final persistentKey = 'cache_$key';
    final jsonStr = _prefs?.getString(persistentKey);
    if (jsonStr != null) {
      try {
        final Map<String, dynamic> data = json.decode(jsonStr);
        final timestamp = data['timestamp'] as int;
        final value = data['value'];

        // Check if expired
        final age = DateTime.now().millisecondsSinceEpoch - timestamp;
        if (maxAge == null || age < maxAge.inMilliseconds) {
          // Add to memory cache and return
          _memoryCache[key] = _CacheEntry(value, timestamp);
          log('Cache hit (persistent): $key');
          return value as T?;
        } else {
          // Remove expired entry
          await _prefs?.remove(persistentKey);
          log('Cache expired (persistent): $key');
        }
      } catch (e) {
        logError('Error parsing cache for key $key: $e');
        await _prefs?.remove(persistentKey);
      }
    }

    return null;
  }

  /// Set a value in both memory and persistent cache
  Future<void> set<T>(String key, T value, {bool persistToDisk = true}) async {
    if (!_initialized) await init();

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    _memoryCache[key] = _CacheEntry(value, timestamp);

    if (persistToDisk) {
      try {
        final Map<String, dynamic> data = {
          'timestamp': timestamp,
          'value': value,
        };
        final jsonStr = json.encode(data);
        await _prefs?.setString('cache_$key', jsonStr);
        log('Cache set (persistent): $key');
      } catch (e) {
        logError('Error saving to persistent cache for key $key: $e');
      }
    } else {
      log('Cache set (memory only): $key');
    }
  }

  /// Remove a value from both memory and persistent cache
  Future<void> remove(String key) async {
    if (!_initialized) await init();

    _memoryCache.remove(key);
    await _prefs?.remove('cache_$key');
    log('Cache removed: $key');
  }

  /// Clear all cached values
  Future<void> clear() async {
    if (!_initialized) await init();

    _memoryCache.clear();
    
    // Only clear cache-related keys
    final keys = _prefs?.getKeys() ?? {};
    for (final key in keys) {
      if (key.startsWith('cache_')) {
        await _prefs?.remove(key);
      }
    }
    
    log('Cache cleared');
  }

  /// Check if a key exists in the cache and is not expired
  Future<bool> exists(String key, {Duration? maxAge}) async {
    final value = await get(key, maxAge: maxAge);
    return value != null;
  }
}

/// Internal class to represent a cached entry with its timestamp
class _CacheEntry {
  final dynamic value;
  final int timestamp;

  _CacheEntry(this.value, this.timestamp);

  bool isExpired(Duration? maxAge) {
    if (maxAge == null) return false;
    final age = DateTime.now().millisecondsSinceEpoch - timestamp;
    return age > maxAge.inMilliseconds;
  }
}