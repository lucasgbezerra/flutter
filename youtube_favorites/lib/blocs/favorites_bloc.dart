import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_favorites/models/video.dart';

class FavoritesBloc extends BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFavorites => _favController.stream;

  FavoritesBloc() {
    _getFavorites();
  }

  void toggleFavorites(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favController.sink.add(_favorites);
    _saveFavorites();
  }

  void _saveFavorites() async {
    await SharedPreferences.getInstance().then((value) {
      value.setString("favorites", json.encode(_favorites));
    });
  }

  void _getFavorites() async {
    final _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey("favorites")) {
      final _json = _prefs.getString("favorites");
      _favorites = json.decode(_json!).map((k, v) {
        return MapEntry(k, Video.fromJson(v));
      }).cast<String, Video>();

      _favController.sink.add(_favorites);
    }
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
