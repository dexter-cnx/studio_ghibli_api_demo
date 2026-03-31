/// Application router using go_router.
///
/// Routes from `agents/shared/repo-rules.md`:
/// - `/films`
/// - `/films/:id`
/// - `/favorites`
/// - `/recently-viewed`
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/favorites/presentation/pages/favorites_page.dart';
import '../features/films/presentation/pages/film_detail_page.dart';
import '../features/films/presentation/pages/film_list_page.dart';
import '../features/recently_viewed/presentation/pages/recently_viewed_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/films',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/films',
              name: 'films',
              builder: (context, state) => const FilmListPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              name: 'favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/recently-viewed',
              name: 'recently-viewed',
              builder: (context, state) => const RecentlyViewedPage(),
            ),
          ],
        ),
      ],
    ),
    // Film detail is pushed onto the root navigator (full-screen)
    GoRoute(
      path: '/films/:id',
      name: 'film-detail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final filmId = state.pathParameters['id']!;
        return FilmDetailPage(filmId: filmId);
      },
    ),
  ],
);

/// Bottom-navigation app shell with 3 tabs.
class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie_rounded),
            label: 'Films',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'Recent',
          ),
        ],
      ),
    );
  }
}
