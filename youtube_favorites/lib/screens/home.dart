import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/blocs/favorites_bloc.dart';
import 'package:youtube_favorites/blocs/videos_bloc.dart';
import 'package:youtube_favorites/delegates/data_search.dart';
import 'package:youtube_favorites/models/video.dart';
import 'package:youtube_favorites/screens/favorites_screen.dart';
import 'package:youtube_favorites/widgets/video_tile_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideosBloc bloc = BlocProvider.getBloc<VideosBloc>();

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: SizedBox(
            height: 25.0,
            child: Image.asset('images/youtube.png'),
          ),
          backgroundColor: Colors.black87,
          actions: [
            Container(
              alignment: Alignment.center,
              width: 24,
              child: StreamBuilder<Map<String, Video>>(
                  stream: BlocProvider.getBloc<FavoritesBloc>().outFavorites,
                  initialData: const {},
                  builder: (context, snapshot) {
                    return Text(
                      "${snapshot.data!.length}",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    );
                  }),
            ),
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FavoritesScreen()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) {
                  bloc.inSearch.add(result);
                }
              },
            )
          ],
        ),
        body: StreamBuilder<List<Video>>(
          stream: bloc.outVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    if (index < snapshot.data!.length) {
                      return VideoTileWidget(snapshot.data![index]);
                    } else if (index > 1) {
                      bloc.inSearch.add("");
                      return Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  });
            } else {
              return Container();
            }
          },
        ));
  }
}
