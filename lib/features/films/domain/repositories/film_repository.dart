/// Abstract film repository contract.
///
/// Domain layer defines what it needs; data layer decides how to deliver it.
library;

import '../entities/film.dart';

abstract class FilmRepository {
  /// Fetch all films. Implementations should follow cache-first pattern.
  Future<List<Film>> getFilms({bool forceRefresh = false});

  /// Fetch a single film by ID.
  Future<Film> getFilmById(String id);
}
