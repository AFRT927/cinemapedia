import 'dart:convert';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

/**
 * Este datasource esta especializado y esta concebido
 * unicamente para interactuar con el endpoint de TMDB
 */
class MovieDbDataSource extends MoviesDataSource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'lenguage': 'es-MX'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // TODO: implement getNowPlaying
    final response = await dio.get('/movie/now_playing');
    
    final movieDbResponse = MovieDbResponse.fromJson(jsonDecode(response.data));    
    
   
    final List<Movie> movies = movieDbResponse.results
    .where((m) => m.posterPath != '')
    .map((m){
      return MovieMapper.movieDbToEntity(m);
    }).toList();
    
    return movies;
  }

}