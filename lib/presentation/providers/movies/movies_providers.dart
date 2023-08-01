import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRespositoryProvider).getNowPlaying;
return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});


// el objetivo de definir este callback es: definir el caso de uso
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier <List<Movie>>{
  
  int currentPage = 0;
  MovieCallback fetchMoreMovies;


  MoviesNotifier({
    required this.fetchMoreMovies
    }):super([]); // inicializacion

  Future<void> loadNextPage() async {
    currentPage++;
    //state <------modify
    print('fetch movies');
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);// todo get now playing
    state = [...state, ...movies];
  }


}