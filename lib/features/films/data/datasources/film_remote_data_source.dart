/// Remote data source — fetches films from the Ghibli API via Dio.
library;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../dtos/film_dto.dart';

class FilmRemoteDataSource {
  const FilmRemoteDataSource(this._dio);
  final Dio _dio;

  Future<List<FilmDto>> getFilms() async {
    final response = await _dio.get<List<dynamic>>(ApiConstants.films);
    return (response.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(FilmDto.fromJson)
        .toList();
  }

  Future<FilmDto> getFilmById(String id) async {
    final response =
        await _dio.get<Map<String, dynamic>>(ApiConstants.filmById(id));
    return FilmDto.fromJson(response.data!);
  }
}

final filmRemoteDataSourceProvider = Provider<FilmRemoteDataSource>((ref) {
  return FilmRemoteDataSource(ref.watch(dioProvider));
});
