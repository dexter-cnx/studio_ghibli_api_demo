/// Film detail page — full information about a selected film.
///
/// Per `design/stitch/screen_specs.md`:
/// title · original title · romanised title · release year · running time ·
/// score · director · producer · long synopsis · favorite action ·
/// related people & locations section.
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/spacing.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loading_widget.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../providers/film_providers.dart';
import '../widgets/metadata_chip.dart';

class FilmDetailPage extends ConsumerWidget {
  const FilmDetailPage({super.key, required this.filmId});

  final String filmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filmAsync = ref.watch(filmDetailProvider(filmId));
    final theme = Theme.of(context);

    return Scaffold(
      body: filmAsync.when(
        loading: () => const AppLoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: tr('films.error'),
          onRetry: () => ref.invalidate(filmDetailProvider(filmId)),
        ),
        data: (film) {
          final isFavorite = ref.watch(isFavoriteProvider(film.id));

          return CustomScrollView(
            slivers: [
              // ─── Banner app bar ─────────────────────────────
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: film.movieBanner,
                    fit: BoxFit.cover,
                    color: Colors.black.withValues(alpha: 0.3),
                    colorBlendMode: BlendMode.darken,
                    errorWidget: (_, __, ___) => Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: isFavorite ? theme.colorScheme.error : null,
                    ),
                    onPressed: () {
                      final added = ref
                          .read(favoritesNotifierProvider.notifier)
                          .toggle(film.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            added
                                ? tr('film_detail.added_to_favorites')
                                : tr('film_detail.removed_from_favorites'),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // ─── Content ────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(film.title, style: theme.textTheme.headlineMedium),
                      const SizedBox(height: AppSpacing.sm),

                      // Original title
                      if (film.originalTitle.isNotEmpty) ...[
                        Text(
                          film.originalTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                      ],

                      // Romanised title
                      if (film.originalTitleRomanised.isNotEmpty) ...[
                        Text(
                          film.originalTitleRomanised,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],

                      // Metadata chips
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          MetadataChip(
                            label: film.releaseDate,
                            icon: Icons.calendar_today_outlined,
                          ),
                          MetadataChip(
                            label: tr('film_detail.running_time_value',
                                namedArgs: {'minutes': film.runningTime}),
                            icon: Icons.schedule_outlined,
                          ),
                          MetadataChip(
                            label: '${film.rtScore}%',
                            icon: Icons.star_outline_rounded,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Director & Producer
                      _InfoRow(
                        label: tr('film_detail.director'),
                        value: film.director,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _InfoRow(
                        label: tr('film_detail.producer'),
                        value: film.producer,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Synopsis
                      Text(
                        tr('film_detail.synopsis'),
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        film.description,
                        style: theme.textTheme.bodyLarge,
                      ),

                      const SizedBox(height: AppSpacing.xxl),

                      // Related sections (placeholder for lazy loading)
                      if (film.peopleUrls.isNotEmpty &&
                          film.peopleUrls.first != _kUnresolved) ...[
                        Text(
                          tr('film_detail.related_people'),
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Characters will be loaded on demand.',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],

                      if (film.locationUrls.isNotEmpty &&
                          film.locationUrls.first != _kUnresolved) ...[
                        Text(
                          tr('film_detail.related_locations'),
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Locations will be loaded on demand.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],

                      // Bottom spacing
                      const SizedBox(height: AppSpacing.xxl * 2),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static const _kUnresolved =
      'https://ghibliapi.vercel.app/people/'; // no id = unresolved
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: theme.textTheme.labelMedium,
          ),
        ),
        Expanded(
          child: Text(value, style: theme.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
