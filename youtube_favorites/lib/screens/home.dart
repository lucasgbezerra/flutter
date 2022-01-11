import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites/blocs/videos_bloc.dart';
import 'package:youtube_favorites/delegates/data_search.dart';
import 'package:youtube_favorites/models/video.dart';
import 'package:youtube_favorites/widgets/video_tile_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final VideosBloc bloc = BlocProvider.getBloc<VideosBloc>();
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          title: Container(
            height: 25.0,
            child: Image.asset('images/youtube.png'),
          ),
          backgroundColor: Colors.black87,
          actions: [
            Container(
              alignment: Alignment.center,
              width: 24,
              child: const Text(
                "0",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {},
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
        body: StreamBuilder <List<Video>>(
          stream: bloc.outVideos,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                
                return VideoTileWidget(snapshot.data![index]);
              });
            }else{
              return Container();
            }
          },
        ));
  }
}
