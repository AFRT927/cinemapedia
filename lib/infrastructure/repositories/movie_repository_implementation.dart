import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';


/**
 * la implementacion del repository lo que hace es
 * llamar al datasource y del data source, llama sus
 * metodos
 */
class MovieReposotoryImpl extends MoviesRespository {
    
    // ojo, MoviesDataSource es la clase abstracta (interface)
    final MoviesDataSource moviesDataSource;

    MovieReposotoryImpl({required this.moviesDataSource});

    @override
    Future<List<Movie>> getNowPlaying({int page = 1}){
      return moviesDataSource.getNowPlaying(page: page);
    }
    
    @override
    Future<List<Movie>> getPopular({int page = 1}) {
      return moviesDataSource.getPopular(page: page);
    }

}