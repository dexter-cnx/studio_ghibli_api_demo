/// Recently viewed page — compact list of recently opened films.
///
/// Per `design/stitch/screen_specs.md`:
/// compact recent film list · empty state.
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
import '../providers/recently_viewed_providers.dart';

class RecentlyViewedPage extends ConsumerWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentIds = ref.watch(recentlyViewedNotifierProvider);
    final allFilmsAsync = ref.watch(filmsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('recently_viewed.title')),
      ),
      body: recentIds.isEmpty
          ? AppEmptyWidget(
              message: tr('recently_viewed.empty'),
              subtitle: tr('recently_viewed.empty_subtitle'),
              icon: Icons.history_rounded,
            )
          : allFilmsAsync.when(
              loading: () => const AppLoadingWidget(),
              error: (_, __) => AppEmptyWidget(
                message: tr('recently_viewed.empty'),
                icon: Icons.history_rounded,
              ),
              data: (allFilms) {
                // Preserve order from recentIds (most recent first)
                final filmMap = {for (final f in allFilms) f.id: f};
                final recentFilms = recentIds
                    .map((id) => filmMap[id])
                    .whereType<Film>()
                    .toList();

                if (recentFilms.isEmpty) {
                  return AppEmptyWidget(
                    message: tr('recently_viewed.empty'),
                    subtitle: tr('recently_viewed.empty_subtitle'),
                    icon: Icons.history_rounded,
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm,
                  ),
                  itemCount: recentFilms.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final film = recentFilms[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.xs,
                      ),
                      leading: Icon(
                        Icons.movie_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      title: Text(
                        film.title,
                        style: theme.textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        '${film.releaseDate} · ${film.director}',
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        ref
                            .read(recentlyViewedNotifierProvider.notifier)
                            .addFilm(film.id);
                        context.push('/films/${film.id}');
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
