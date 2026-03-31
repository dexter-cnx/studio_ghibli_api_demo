// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilmDto _$FilmDtoFromJson(Map<String, dynamic> json) => FilmDto(
  id: json['id'] as String,
  title: json['title'] as String,
  originalTitle: json['original_title'] as String,
  originalTitleRomanised: json['original_title_romanised'] as String,
  image: json['image'] as String,
  movieBanner: json['movie_banner'] as String,
  description: json['description'] as String,
  director: json['director'] as String,
  producer: json['producer'] as String,
  releaseDate: json['release_date'] as String,
  runningTime: json['running_time'] as String,
  rtScore: json['rt_score'] as String,
  people: (json['people'] as List<dynamic>).map((e) => e as String).toList(),
  locations:
      (json['locations'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$FilmDtoToJson(FilmDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'original_title': instance.originalTitle,
  'original_title_romanised': instance.originalTitleRomanised,
  'image': instance.image,
  'movie_banner': instance.movieBanner,
  'description': instance.description,
  'director': instance.director,
  'producer': instance.producer,
  'release_date': instance.releaseDate,
  'running_time': instance.runningTime,
  'rt_score': instance.rtScore,
  'people': instance.people,
  'locations': instance.locations,
};
