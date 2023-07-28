import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

/**
 * Mapper: el objetivo del mapper es leer diferentes modelos
 * y en base a estos, crear la entidad de interes, en este
 * caso la entidad Movie.
 */

class MovieMapper {

   static Movie movieDbToEntity( MovieFromMovieDB movieDb) => Movie(
    adult: movieDb.adult, 
    backdropPath: (movieDb.backdropPath != '') ? 
    'https://image.tmdb.org/t/p/w500/${ movieDb.backdropPath }' 
    : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    genreId: movieDb.genreIds.map((id) => '$id').toList(), 
    id: movieDb.id, 
    originalLenguage: movieDb.originalLanguage, 
    originalTitle: movieDb.originalTitle, 
    overview: movieDb.overview, 
    popularity: movieDb.popularity, 
    posterPath: (movieDb.posterPath != '') ? 
    'https://image.tmdb.org/t/p/w500/${ movieDb.posterPath }' 
    : 'no-poster', 
    releseDate: movieDb.releaseDate, 
    title: movieDb.title, 
    video: movieDb.video, 
    voteAverage: movieDb.voteAverage, 
    voteCount: movieDb.voteCount
    );

}

