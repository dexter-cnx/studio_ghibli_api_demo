/// Riverpod providers for favorites.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/favorites_repository_impl.dart';

/// Notifier that manages the favorites list and persists changes.
class FavoritesNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final repo = ref.watch(favoritesRepositoryProvider);
    return repo.getFavoriteIds();
  }

  /// Toggle a film id. Returns `true` if added, `false` if removed.
  bool toggle(String filmId) {
    final repo = ref.read(favoritesRepositoryProvider);
    final added = repo.toggle(filmId);
    state = repo.getFavoriteIds(); // refresh state
    return added;
  }

  Future<void> remove(String filmId) async {
    final repo = ref.read(favoritesRepositoryProvider);
    await repo.remove(filmId);
    state = repo.getFavoriteIds();
  }
}

final favoritesNotifierProvider =
    NotifierProvider<FavoritesNotifier, List<String>>(FavoritesNotifier.new);

/// Convenience provider — check if a specific film id is a favorite.
final isFavoriteProvider = Provider.family<bool, String>((ref, filmId) {
  final favorites = ref.watch(favoritesNotifierProvider);
  return favorites.contains(filmId);
});
