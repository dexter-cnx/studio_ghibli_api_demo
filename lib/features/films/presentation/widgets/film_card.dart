/// Film card widget per `design/stitch/component_inventory.md`.
///
/// Shows: title · original title · release year · score · favorite action.
library;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app/spacing.dart';
import '../../domain/entities/film.dart';
import 'metadata_chip.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({
    super.key,
    required this.film,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final Film film;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ─── Banner image ──────────────────────────────────
            AspectRatio(
              aspectRatio: 16 / 7,
              child: CachedNetworkImage(
                imageUrl: film.movieBanner,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                errorWidget: (_, __, ___) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.movie_outlined,
                    size: 32,
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),

            // ─── Card body ─────────────────────────────────────
            Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row with favorite button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              film.title,
                              style: theme.textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (film.originalTitle.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                film.originalTitle,
                                style: theme.textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton(
                        onPressed: onToggleFavorite,
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: isFavorite
                              ? theme.colorScheme.error
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                        visualDensity: VisualDensity.compact,
                        tooltip: isFavorite
                            ? 'Remove from favorites'
                            : 'Add to favorites',
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

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
                        label: '${film.runningTime} min',
                        icon: Icons.schedule_outlined,
                      ),
                      MetadataChip(
                        label: '${film.rtScore}%',
                        icon: Icons.star_outline_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
