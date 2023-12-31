
import 'package:cinemapedia/domain/entities/movie.dart';

/**
 * Ojo: notese que la clase abstacta MovieRespository
 * es exactamente igual a la clase abstacta  MovieDataSource.
 * cual es la diferencia entre ellas?
 * R// basicamente, nuestros origenes de datos son
 * MovieDatasource que van a ser llamados por el MovieRepository.
 */
abstract class MoviesRespository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getTopRated({ int page = 1 });

  Future<List<Movie>> getUpcoming({ int page = 1 });

  Future<Movie> getMovieById(String id);

}