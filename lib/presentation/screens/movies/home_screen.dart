import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeView()
      ),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  ConsumerState<_HomeView> createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<_HomeView> {

@override
  void initState(){
    super.initState();
    
    // se manda a ejecutar la peticion pero no se renderiza la data
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();       

  }

  @override
  Widget build(BuildContext context) {
    // espera a que la peticion obtenga el resultado y renderiza la data
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    
    if (nowPlayingMovies.length == 0) return CircularProgressIndicator();

    return Column(
      children: [
        
        CustomAppbar(),
        MoviesSlideShow(movies: nowPlayingMovies),


      ],
    );
  }
}
