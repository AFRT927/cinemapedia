import 'package:cinemapedia/presentation/providers/providers.dart';
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
        child: _HomeView(),        
      ),
      bottomNavigationBar: CustomBottomNavigation(),
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
    ref.read(popularMoviesProvider.notifier).loadNextPage();  
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();  
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {
    // espera a que la peticion obtenga el resultado y renderiza la data
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    
    if (nowPlayingMovies.isEmpty) return const CircularProgressIndicator();

    return CustomScrollView(
      slivers: [
     
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
        children: [
          
             
          MoviesSlideShow(movies: slideShowMovies),
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: 'En Cines',
            subTitle: 'Lunes 20',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
            ),    
          
          MovieHorizontalListView(
            movies: upcomingMovies,
            title: 'Proximamente',
            subTitle: 'Este mes',
            loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
            ),            
    
          
          MovieHorizontalListView(
            movies: popularMovies,
            title: 'Populares',          
            loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
            ),          
    
          
          MovieHorizontalListView(
            movies: topRatedMovies,
            title: 'Mejor Calificadas',
            subTitle: 'De todos los tiempos',
            loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()
            ),

          const SizedBox(height: 50,)
    
    
        ],
      );
            },
            childCount: 1
            )
          )
      ]
    );
  }
}
