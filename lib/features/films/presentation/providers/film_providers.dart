/// Riverpod providers for the films feature.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/film_repository_impl.dart';
import '../../domain/entities/film.dart';

/// All films — supports loading, error, and data states via [AsyncValue].
final filmsProvider = FutureProvider<List<Film>>((ref) async {
  final repo = await ref.watch(filmRepositoryProvider.future);
  return repo.getFilms();
});

/// Refreshable films — invalidate to force network fetch.
final filmsRefreshProvider = FutureProvider<List<Film>>((ref) async {
  final repo = await ref.watch(filmRepositoryProvider.future);
  return repo.getFilms(forceRefresh: true);
});

/// Single film by ID.
final filmDetailProvider =
    FutureProvider.family<Film, String>((ref, id) async {
  final repo = await ref.watch(filmRepositoryProvider.future);
  return repo.getFilmById(id);
});

/// Search query state.
final filmSearchQueryProvider = StateProvider<String>((ref) => '');

/// Sort option.
enum FilmSortOption { title, year, score }

final filmSortOptionProvider =
    StateProvider<FilmSortOption>((ref) => FilmSortOption.title);

/// Filtered and sorted film list.
final filteredFilmsProvider = Provider<AsyncValue<List<Film>>>((ref) {
  final filmsAsync = ref.watch(filmsProvider);
  final query = ref.watch(filmSearchQueryProvider).toLowerCase();
  final sort = ref.watch(filmSortOptionProvider);

  return filmsAsync.whenData((films) {
    var result = films.toList();

    // Filter
    if (query.isNotEmpty) {
      result = result.where((f) {
        return f.title.toLowerCase().contains(query) ||
            f.originalTitle.toLowerCase().contains(query) ||
            f.director.toLowerCase().contains(query);
      }).toList();
    }

    // Sort
    result.sort((a, b) {
      return switch (sort) {
        FilmSortOption.title => a.title.compareTo(b.title),
        FilmSortOption.year => a.releaseDate.compareTo(b.releaseDate),
        FilmSortOption.score =>
          (int.tryParse(b.rtScore) ?? 0)
              .compareTo(int.tryParse(a.rtScore) ?? 0),
      };
    });

    return result;
  });
});
