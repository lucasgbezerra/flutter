import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/blocs/favorites_bloc.dart';
import 'package:youtube_favorites/models/video.dart';
import 'package:youtube_favorites/screens/video_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTileWidget extends StatelessWidget {
  final Video video;
  const VideoTileWidget(this.video, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesBloc blocFav = BlocProvider.getBloc<FavoritesBloc>();
    return GestureDetector(
      onTap: () {
        final controller = YoutubePlayerController(
          initialVideoId: video.id,
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
          ),
        );
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => VideoScreen(controller)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          video.channel,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                    stream: blocFav.outFavorites,
                    initialData: const {},
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                            icon: Icon(
                              snapshot.data!.containsKey(video.id)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.white,
                            ),
                            iconSize: 30,
                            onPressed: () {
                              blocFav.toggleFavorites(video);
                            });
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
