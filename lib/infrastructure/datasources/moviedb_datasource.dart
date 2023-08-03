import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
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


List<Movie> _jsonToMovies(Map<String, dynamic> json) {    
    // capa de conversion 1: de respuesta http al modelo (para facilitar el manejo de la respuesta)
    final movieDbResponse = MovieDbResponse.fromJson(json);    
    
   // capa de conversion 2: del modelo a la entidad, para crear las entidades
    final List<Movie> movies = movieDbResponse.results
    .where((m) => m.posterPath != 'no-poster')
    .map((m){
      return MovieMapper.movieDbToEntity(m);
    }).toList();
    
    return movies;
}

Movie _jsonToMovie(Map<String, dynamic> json) {    
    // capa de conversion 1: de respuesta http al modelo (para facilitar el manejo de la respuesta)
   final movieDetails = MovieDetails.fromJson(json);
   final movie = MovieMapper.movieDetailsToEntity(movieDetails);
   return movie;
}




  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // TODO: implement getNowPlaying
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      });

    return _jsonToMovies(response.data);
  }

   @override
  Future<List<Movie>> getPopular({int page = 1}) async {

       final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
      });    

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
           final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
      });    

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
           final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
      });    

    return _jsonToMovies(response.data);    
  }

  @override
  Future<Movie> getMovieById(id) async {
           final response = await dio.get('/movie/$id');
           if(response.statusCode != 200) throw Exception('Movie with id $id not found');   

    return _jsonToMovie(response.data);  
  }

}
