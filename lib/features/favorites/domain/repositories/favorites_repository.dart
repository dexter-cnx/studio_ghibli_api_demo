/// Favorites repository contract.
library;

abstract class FavoritesRepository {
  List<String> getFavoriteIds();
  bool isFavorite(String filmId);
  /// Toggles favorite state. Returns `true` if added, `false` if removed.
  bool toggle(String filmId);
  Future<void> remove(String filmId);
}
