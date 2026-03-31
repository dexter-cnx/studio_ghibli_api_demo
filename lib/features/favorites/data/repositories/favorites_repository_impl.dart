/// SharedPreferences-backed favorites repository.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/local_storage.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._storage);
  final LocalStorage _storage;

  static const _key = 'favorite_film_ids';

  @override
  List<String> getFavoriteIds() => _storage.getStringList(_key);

  @override
  bool isFavorite(String filmId) => _storage.listContains(_key, filmId);

  @override
  bool toggle(String filmId) {
    final list = _storage.getStringList(_key);
    final existed = list.remove(filmId);
    if (!existed) list.add(filmId);
    _storage.setStringList(_key, list);
    return !existed; // true = was added
  }

  @override
  Future<void> remove(String filmId) => _storage.removeFromList(_key, filmId);
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(ref.watch(localStorageProvider));
});
