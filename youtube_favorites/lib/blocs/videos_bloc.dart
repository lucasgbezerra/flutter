import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:youtube_favorites/models/video.dart';
import 'package:youtube_favorites/resources/api.dart';

class VideosBloc extends BlocBase {
  Api? api;

  List<Video>? videos;

  final _videosController = StreamController<List<Video>>();
  Stream<List<Video>> get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  // Utilizando uma stream para enviar infos ao bloc
  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String? search) async {
    if (search != null && search != "") {
      _videosController.sink.add([]);
      videos = await api!.search(search);
    } else {
      videos = videos! + await api!.nextPage();
    }
    _videosController.sink.add(videos!);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
    super.dispose();

  }
}
