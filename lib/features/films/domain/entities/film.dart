/// Film entity — the domain representation of a Ghibli film.
///
/// Intentionally free of JSON annotations and Flutter dependencies.
library;

import 'package:equatable/equatable.dart';

class Film extends Equatable {
  const Film({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.originalTitleRomanised,
    required this.image,
    required this.movieBanner,
    required this.description,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.runningTime,
    required this.rtScore,
    required this.peopleUrls,
    required this.locationUrls,
  });

  final String id;
  final String title;
  final String originalTitle;
  final String originalTitleRomanised;
  final String image;
  final String movieBanner;
  final String description;
  final String director;
  final String producer;
  final String releaseDate;
  final String runningTime;
  final String rtScore;
  final List<String> peopleUrls;
  final List<String> locationUrls;

  @override
  List<Object?> get props => [id];
}
