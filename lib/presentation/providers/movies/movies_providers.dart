import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRespositoryProvider).getNowPlaying;
return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRespositoryProvider).getPopular;
return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRespositoryProvider).getTopRated;
return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRespositoryProvider).getUpcoming;
return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});


// el objetivo de definir este callback es: definir el caso de uso
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier <List<Movie>>{
  
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;


  MoviesNotifier({
    required this.fetchMoreMovies
    }):super([]); // inicializacion

  Future<void> loadNextPage() async {

    if(isLoading) return;
    isLoading = true;
    currentPage++;
    //state <------modify
    print('fetch movies');
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);// todo get now playing
    state = [...state, ...movies];
    isLoading = false;
  }


}