/// Local data source — reads/writes cached film JSON.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/json_cache.dart';
import '../dtos/film_dto.dart';

class FilmLocalDataSource {
  const FilmLocalDataSource(this._cache);
  final JsonCache _cache;

  static const _filmsKey = 'films_list';
  static String _filmKey(String id) => 'film_$id';

  // ─── Film list ────────────────────────────────────────────────
  Future<List<FilmDto>?> getCachedFilms() async {
    final entry = await _cache.read(_filmsKey);
    if (entry == null) return null;
    return (entry.data as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(FilmDto.fromJson)
        .toList();
  }

  Future<void> cacheFilms(List<FilmDto> films) async {
    await _cache.write(
      _filmsKey,
      films.map((f) => f.toJson()).toList(),
    );
  }

  Future<bool> isFilmListStale() async {
    final entry = await _cache.read(_filmsKey);
    return entry?.isStale() ?? true;
  }

  // ─── Single film ──────────────────────────────────────────────
  Future<FilmDto?> getCachedFilm(String id) async {
    final entry = await _cache.read(_filmKey(id));
    if (entry == null) return null;
    return FilmDto.fromJson(entry.data as Map<String, dynamic>);
  }

  Future<void> cacheFilm(FilmDto film) async {
    await _cache.write(_filmKey(film.id), film.toJson());
  }
}

final filmLocalDataSourceProvider = FutureProvider<FilmLocalDataSource>(
  (ref) async {
    final cache = await ref.watch(jsonCacheProvider.future);
    return FilmLocalDataSource(cache);
  },
);
