import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/**
 * La ventaja de utilizar GoRouter es que nos evita
 * tener que hacer configuraciones especiales si queremos
 * pasar toda nuestra logica a la web. Tambien nos va a 
 * servir muchisimo si se quiere integrar el DeepLinking
 * entre otras cosas.
 */
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen()
      )

  ]
  );