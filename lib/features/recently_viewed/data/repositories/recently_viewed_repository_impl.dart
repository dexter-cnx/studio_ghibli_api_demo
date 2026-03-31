/// SharedPreferences-backed recently viewed repository.
///
/// Caps the list at 20 items and prepends new entries.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/local_storage.dart';
import '../../domain/repositories/recently_viewed_repository.dart';

class RecentlyViewedRepositoryImpl implements RecentlyViewedRepository {
  const RecentlyViewedRepositoryImpl(this._storage);
  final LocalStorage _storage;

  static const _key = 'recently_viewed_film_ids';
  static const _maxItems = 20;

  @override
  List<String> getRecentIds() => _storage.getStringList(_key);

  @override
  Future<void> addFilm(String filmId) =>
      _storage.prependToList(_key, filmId, maxLength: _maxItems);
}

final recentlyViewedRepositoryProvider =
    Provider<RecentlyViewedRepository>((ref) {
  return RecentlyViewedRepositoryImpl(ref.watch(localStorageProvider));
});
