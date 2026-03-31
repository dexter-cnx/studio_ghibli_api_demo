/// Favorites page — review locally saved films.
///
/// Per `design/stitch/screen_specs.md`:
/// saved film list · quick remove action · empty state.
library;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/spacing.dart';
import '../../../../core/widgets/app_empty_widget.dart';
import '../../../../core/widgets/app_loading_widget.dart';
import '../../../films/domain/entities/film.dart';
import '../../../films/presentation/providers/film_providers.dart';
import '../../../recently_viewed/presentation/providers/recently_viewed_providers.dart';
import '../providers/favorites_providers.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesNotifierProvider);
    final allFilmsAsync = ref.watch(filmsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('favorites.title')),
      ),
      body: favoriteIds.isEmpty
          ? AppEmptyWidget(
              message: tr('favorites.empty'),
              subtitle: tr('favorites.empty_subtitle'),
              icon: Icons.favorite_outline_rounded,
            )
          : allFilmsAsync.when(
              loading: () => const AppLoadingWidget(),
              error: (_, __) => AppEmptyWidget(
                message: tr('favorites.empty'),
                subtitle: tr('favorites.empty_subtitle'),
                icon: Icons.favorite_outline_rounded,
              ),
              data: (allFilms) {
                final favoriteFilms = allFilms
                    .where((f) => favoriteIds.contains(f.id))
                    .toList();

                if (favoriteFilms.isEmpty) {
                  return AppEmptyWidget(
                    message: tr('favorites.empty'),
                    subtitle: tr('favorites.empty_subtitle'),
                    icon: Icons.favorite_outline_rounded,
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm,
                  ),
                  itemCount: favoriteFilms.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final film = favoriteFilms[index];
                    return _FavoriteFilmTile(film: film);
                  },
                );
              },
            ),
    );
  }
}

class _FavoriteFilmTile extends ConsumerWidget {
  const _FavoriteFilmTile({required this.film});
  final Film film;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      title: Text(
        film.title,
        style: theme.textTheme.titleSmall,
      ),
      subtitle: Text(
        '${film.releaseDate} · ${film.director}',
        style: theme.textTheme.bodySmall,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.favorite_rounded,
          color: theme.colorScheme.error,
        ),
        tooltip: 'Remove from favorites',
        onPressed: () {
          ref.read(favoritesNotifierProvider.notifier).remove(film.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(tr('favorites.removed'))),
          );
        },
      ),
      onTap: () {
        ref
            .read(recentlyViewedNotifierProvider.notifier)
            .addFilm(film.id);
        context.push('/films/${film.id}');
      },
    );
  }
}
