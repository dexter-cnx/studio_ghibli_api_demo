/// Film DTO for JSON serialisation.
///
/// Stays in the data layer — never leaks into presentation.
library;

import 'package:json_annotation/json_annotation.dart';

part 'film_dto.g.dart';

@JsonSerializable()
class FilmDto {
  const FilmDto({
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
    required this.people,
    required this.locations,
  });

  final String id;
  final String title;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  @JsonKey(name: 'original_title_romanised')
  final String originalTitleRomanised;
  final String image;
  @JsonKey(name: 'movie_banner')
  final String movieBanner;
  final String description;
  final String director;
  final String producer;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'running_time')
  final String runningTime;
  @JsonKey(name: 'rt_score')
  final String rtScore;
  final List<String> people;
  final List<String> locations;

  factory FilmDto.fromJson(Map<String, dynamic> json) =>
      _$FilmDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FilmDtoToJson(this);
}
