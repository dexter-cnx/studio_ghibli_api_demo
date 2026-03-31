/// API configuration constants.
///
/// Centralised so no endpoint strings leak into presentation or domain.
library;

abstract final class ApiConstants {
  static const String baseUrl = 'https://ghibliapi.vercel.app';

  // ─── Resource paths ───────────────────────────────────────────
  static const String films = '/films';
  static String filmById(String id) => '/films/$id';
  static const String people = '/people';
  static String personById(String id) => '/people/$id';
  static const String locations = '/locations';
  static String locationById(String id) => '/locations/$id';
  static const String species = '/species';
  static const String vehicles = '/vehicles';

  // ─── Timeouts ─────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
