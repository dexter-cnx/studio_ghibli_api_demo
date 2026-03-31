/// Maps between [FilmDto] (data) and [Film] (domain).
library;

import '../../domain/entities/film.dart';
import '../dtos/film_dto.dart';

abstract final class FilmMapper {
  static Film fromDto(FilmDto dto) {
    return Film(
      id: dto.id,
      title: dto.title,
      originalTitle: dto.originalTitle,
      originalTitleRomanised: dto.originalTitleRomanised,
      image: dto.image,
      movieBanner: dto.movieBanner,
      description: dto.description,
      director: dto.director,
      producer: dto.producer,
      releaseDate: dto.releaseDate,
      runningTime: dto.runningTime,
      rtScore: dto.rtScore,
      peopleUrls: dto.people,
      locationUrls: dto.locations,
    );
  }

  static FilmDto toDto(Film film) {
    return FilmDto(
      id: film.id,
      title: film.title,
      originalTitle: film.originalTitle,
      originalTitleRomanised: film.originalTitleRomanised,
      image: film.image,
      movieBanner: film.movieBanner,
      description: film.description,
      director: film.director,
      producer: film.producer,
      releaseDate: film.releaseDate,
      runningTime: film.runningTime,
      rtScore: film.rtScore,
      people: film.peopleUrls,
      locations: film.locationUrls,
    );
  }

  static List<Film> fromDtoList(List<FilmDto> dtos) {
    return dtos.map(fromDto).toList();
  }
}
