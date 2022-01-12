import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/blocs/favorites_bloc.dart';
import 'package:youtube_favorites/blocs/videos_bloc.dart';
import 'package:youtube_favorites/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc<VideosBloc>((i) => VideosBloc()), Bloc<FavoritesBloc>((i) => FavoritesBloc())],
      dependencies: [],
      child: MaterialApp(
          title: 'YouTube Favs',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home()),
    );
  }
}
