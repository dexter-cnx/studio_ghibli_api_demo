/// Riverpod providers for recently viewed films.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/recently_viewed_repository_impl.dart';

/// Notifier that manages the recently viewed list.
class RecentlyViewedNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final repo = ref.watch(recentlyViewedRepositoryProvider);
    return repo.getRecentIds();
  }

  Future<void> addFilm(String filmId) async {
    final repo = ref.read(recentlyViewedRepositoryProvider);
    await repo.addFilm(filmId);
    state = repo.getRecentIds();
  }
}

final recentlyViewedNotifierProvider =
    NotifierProvider<RecentlyViewedNotifier, List<String>>(
  RecentlyViewedNotifier.new,
);
