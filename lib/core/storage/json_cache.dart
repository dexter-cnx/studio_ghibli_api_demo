/// File-based JSON cache for offline-first data.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

/// Provides access to the app-specific cache directory.
final cacheDirProvider = FutureProvider<Directory>((ref) async {
  final appDir = await getApplicationDocumentsDirectory();
  final cacheDir = Directory('${appDir.path}/ghibli_cache');
  if (!cacheDir.existsSync()) {
    await cacheDir.create(recursive: true);
  }
  return cacheDir;
});

/// Simple file-backed JSON cache.
///
/// Each cache entry is stored as a JSON file with a metadata wrapper
/// that includes a timestamp for staleness checks.
class JsonCache {
  const JsonCache(this._cacheDir);
  final Directory _cacheDir;

  /// Read cached data. Returns `null` if no cache exists.
  Future<CacheEntry?> read(String key) async {
    final file = _fileFor(key);
    if (!file.existsSync()) return null;
    try {
      final raw = await file.readAsString();
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return CacheEntry(
        data: map['data'],
        cachedAt: DateTime.parse(map['cachedAt'] as String),
      );
    } catch (_) {
      // Corrupted cache — delete and return null.
      await file.delete();
      return null;
    }
  }

  /// Write data to cache with current timestamp.
  Future<void> write(String key, dynamic data) async {
    final file = _fileFor(key);
    final wrapper = {
      'cachedAt': DateTime.now().toUtc().toIso8601String(),
      'data': data,
    };
    await file.writeAsString(jsonEncode(wrapper));
  }

  /// Delete a specific cache entry.
  Future<void> delete(String key) async {
    final file = _fileFor(key);
    if (file.existsSync()) await file.delete();
  }

  /// Clear all cached data.
  Future<void> clear() async {
    if (_cacheDir.existsSync()) {
      await _cacheDir.delete(recursive: true);
      await _cacheDir.create(recursive: true);
    }
  }

  File _fileFor(String key) => File('${_cacheDir.path}/$key.json');
}

/// Wrapper for cached data with a timestamp.
class CacheEntry {
  const CacheEntry({required this.data, required this.cachedAt});
  final dynamic data;
  final DateTime cachedAt;

  /// Whether the cache is older than [maxAge].
  bool isStale({Duration maxAge = const Duration(hours: 1)}) {
    return DateTime.now().toUtc().difference(cachedAt) > maxAge;
  }
}

final jsonCacheProvider = FutureProvider<JsonCache>((ref) async {
  final dir = await ref.watch(cacheDirProvider.future);
  return JsonCache(dir);
});
