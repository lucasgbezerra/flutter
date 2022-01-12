import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_favorites/models/video.dart';
import 'configs.dart';

class Api {
  String? _search;
  String? _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;

    http.Response response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10'),
    );

    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken'),
    );

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    //status seja de sucesso(200)
    //Retorna obj videos criados a partir do Json obtido
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded['nextPageToken'];
      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      //Lança uma exceção
      throw Exception("Ocorreu um erro ao tentar realizar a pesquisa!");
    }
  }
}
