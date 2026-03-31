/// Cache-first film repository implementation.
///
/// Read flow (from `agents/shared/architecture.md`):
/// 1. Read cache first
/// 2. Render immediately if cache exists
/// 3. Fetch remote
/// 4. Persist updated content
/// 5. Refresh UI without blanking working content
library;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/error_mapper.dart';
import '../../domain/entities/film.dart';
import '../../domain/repositories/film_repository.dart';
import '../datasources/film_local_data_source.dart';
import '../datasources/film_remote_data_source.dart';
import '../mappers/film_mapper.dart';

class FilmRepositoryImpl implements FilmRepository {
  const FilmRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final FilmRemoteDataSource remoteDataSource;
  final FilmLocalDataSource localDataSource;

  @override
  Future<List<Film>> getFilms({bool forceRefresh = false}) async {
    // 1. Try cache first (unless forced refresh)
    if (!forceRefresh) {
      final cached = await localDataSource.getCachedFilms();
      if (cached != null && cached.isNotEmpty) {
        // Return cached data quickly. The provider will initiate a
        // background refresh if the data is stale.
        return FilmMapper.fromDtoList(cached);
      }
    }

    // 2. Fetch remote
    try {
      final remoteDtos = await remoteDataSource.getFilms();
      // 3. Persist
      await localDataSource.cacheFilms(remoteDtos);
      // 4. Return fresh data
      return FilmMapper.fromDtoList(remoteDtos);
    } on DioException catch (e) {
      // 5. On failure, try returning stale cache
      final stale = await localDataSource.getCachedFilms();
      if (stale != null && stale.isNotEmpty) {
        return FilmMapper.fromDtoList(stale);
      }
      throw ErrorMapper.fromDioException(e);
    } catch (e) {
      throw ErrorMapper.fromException(e);
    }
  }

  @override
  Future<Film> getFilmById(String id) async {
    // 1. Try cache first
    final cached = await localDataSource.getCachedFilm(id);
    if (cached != null) {
      return FilmMapper.fromDto(cached);
    }

    // 2. Fetch remote
    try {
      final dto = await remoteDataSource.getFilmById(id);
      await localDataSource.cacheFilm(dto);
      return FilmMapper.fromDto(dto);
    } on DioException catch (e) {
      throw ErrorMapper.fromDioException(e);
    } catch (e) {
      throw ErrorMapper.fromException(e);
    }
  }
}

final filmRepositoryProvider = FutureProvider<FilmRepository>((ref) async {
  final remote = ref.watch(filmRemoteDataSourceProvider);
  final local = await ref.watch(filmLocalDataSourceProvider.future);
  return FilmRepositoryImpl(
    remoteDataSource: remote,
    localDataSource: local,
  );
});
