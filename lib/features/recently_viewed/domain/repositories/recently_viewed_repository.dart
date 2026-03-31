/// Recently viewed repository contract.
library;

abstract class RecentlyViewedRepository {
  List<String> getRecentIds();
  Future<void> addFilm(String filmId);
}
