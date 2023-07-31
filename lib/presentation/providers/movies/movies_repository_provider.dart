import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/**
 * Ojo, este provider nunca puede ser modificado(es inmutable)
 * por lo tanto debe ser un provider de solo lectura.
 * Su objetivo es proporcionar la informacion neceraria a todos
 * los demas providers para que estos puedan consultarla
 */

final movieRespositoryProvider = Provider((ref) { 
return MovieReposotoryImpl(moviesDataSource: MovieDbDataSource());
}
);