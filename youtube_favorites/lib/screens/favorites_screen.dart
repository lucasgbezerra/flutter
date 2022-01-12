import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/blocs/favorites_bloc.dart';
import 'package:youtube_favorites/models/video.dart';
import 'package:youtube_favorites/screens/video_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocFav = BlocProvider.getBloc<FavoritesBloc>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        backgroundColor: Colors.black87,
        body: StreamBuilder<Map<String, Video>>(
          stream: blocFav.outFavorites,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.values.map((video) {
                  return InkWell(
                    onTap: () {
                      final controller = YoutubePlayerController(
                        initialVideoId: video.id,
                        flags: const YoutubePlayerFlags(
                          mute: false,
                          autoPlay: true,
                        ),
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoScreen(controller)));
                    },
                    onLongPress: () {
                      blocFav.toggleFavorites(video);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: Image.network(video.thumb),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.title,
                              maxLines: 2,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ))
                      ],
                    ),
                  );
                }).toList(),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
