/// Thin wrapper around [SharedPreferences] for typed local storage.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Must be overridden in [ProviderScope] after awaiting
/// `SharedPreferences.getInstance()` in `main()`.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden with a valid instance.',
  );
});

/// Convenience accessor for list-of-string values stored locally.
class LocalStorage {
  const LocalStorage(this._prefs);
  final SharedPreferences _prefs;

  // ─── String list helpers ───────────────────────────────────────
  List<String> getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }

  /// Adds [id] to front of the list at [key], de-duplicating and capping
  /// the list at [maxLength].
  Future<bool> prependToList(
    String key,
    String id, {
    int maxLength = 20,
  }) {
    final current = getStringList(key);
    current.remove(id);
    current.insert(0, id);
    if (current.length > maxLength) {
      current.removeRange(maxLength, current.length);
    }
    return setStringList(key, current);
  }

  /// Toggles [id] in the list at [key]. Returns `true` if added, `false` if
  /// removed.
  Future<bool> toggleInList(String key, String id) async {
    final current = getStringList(key);
    final existed = current.remove(id);
    if (!existed) current.add(id);
    await setStringList(key, current);
    return !existed; // true = was added
  }

  bool listContains(String key, String id) {
    return getStringList(key).contains(id);
  }

  Future<bool> removeFromList(String key, String id) {
    final current = getStringList(key);
    current.remove(id);
    return setStringList(key, current);
  }
}

final localStorageProvider = Provider<LocalStorage>((ref) {
  return LocalStorage(ref.watch(sharedPreferencesProvider));
});
