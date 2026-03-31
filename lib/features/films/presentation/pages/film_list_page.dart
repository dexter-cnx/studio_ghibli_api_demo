/// Film list page — browse and search films.
///
/// Implements all required states from `agents/shared/repo-rules.md`:
/// loading · success · empty · error · stale-cache.
library;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/spacing.dart';
import '../../../../core/widgets/app_empty_widget.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loading_widget.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../../../recently_viewed/presentation/providers/recently_viewed_providers.dart';
import '../providers/film_providers.dart';
import '../widgets/film_card.dart';

class FilmListPage extends ConsumerWidget {
  const FilmListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredFilms = ref.watch(filteredFilmsProvider);
    final searchQuery = ref.watch(filmSearchQueryProvider);
    final sortOption = ref.watch(filmSortOptionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('films.title')),
      ),
      body: Column(
        children: [
          // ─── Search & sort bar ──────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: tr('films.search_hint'),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () => ref
                                  .read(filmSearchQueryProvider.notifier)
                                  .state = '',
                            )
                          : null,
                    ),
                    onChanged: (value) => ref
                        .read(filmSearchQueryProvider.notifier)
                        .state = value,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Sort segmented button
                PopupMenuButton<FilmSortOption>(
                  icon: const Icon(Icons.sort_rounded),
                  tooltip: 'Sort',
                  initialValue: sortOption,
                  onSelected: (option) => ref
                      .read(filmSortOptionProvider.notifier)
                      .state = option,
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: FilmSortOption.title,
                      child: Text(tr('films.sort_title')),
                    ),
                    PopupMenuItem(
                      value: FilmSortOption.year,
                      child: Text(tr('films.sort_year')),
                    ),
                    PopupMenuItem(
                      value: FilmSortOption.score,
                      child: Text(tr('films.sort_score')),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ─── Film list ──────────────────────────────────────
          Expanded(
            child: filteredFilms.when(
              loading: () => const AppLoadingWidget(),
              error: (error, _) => AppErrorWidget(
                message: tr('films.error'),
                onRetry: () => ref.invalidate(filmsProvider),
              ),
              data: (films) {
                if (films.isEmpty) {
                  return AppEmptyWidget(
                    message: searchQuery.isNotEmpty
                        ? tr('common.no_results')
                        : tr('films.empty'),
                    icon: searchQuery.isNotEmpty
                        ? Icons.search_off_rounded
                        : Icons.movie_outlined,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(filmsProvider);
                    await ref.read(filmsProvider.future);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.sm,
                      bottom: AppSpacing.xxl,
                    ),
                    itemCount: films.length,
                    itemBuilder: (context, index) {
                      final film = films[index];
                      final isFavorite = ref.watch(
                        isFavoriteProvider(film.id),
                      );

                      return FilmCard(
                        film: film,
                        isFavorite: isFavorite,
                        onTap: () {
                          // Track recently viewed
                          ref
                              .read(
                                recentlyViewedNotifierProvider.notifier,
                              )
                              .addFilm(film.id);
                          context.push('/films/${film.id}');
                        },
                        onToggleFavorite: () {
                          ref
                              .read(favoritesNotifierProvider.notifier)
                              .toggle(film.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
