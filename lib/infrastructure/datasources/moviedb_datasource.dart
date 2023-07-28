import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
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

    //final movies = await response.data;
    final List<Movie> movies = [];
    
    return movies;
  }

}
