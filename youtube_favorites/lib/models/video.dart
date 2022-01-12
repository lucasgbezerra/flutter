
class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({
    required this.id,
    required this.title,
    required this.thumb,
    required this.channel,
  });

  Map<String, dynamic> toJson() {
    return {
      'videoId': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
    };
  }


  factory Video.fromJson(Map<String, dynamic> map) {
    // print("MAP " + map.toString());
    if (map.containsKey('id')) {
      return Video(
        id: map['id']['videoId'] ?? '',
        title: map['snippet']['title'] ?? '',
        thumb: map['snippet']['thumbnails']['high']['url'] ?? '',
        channel: map['snippet']['channelTitle'] ?? '',
      );
    } else {
      return Video(
        id: map['videoId'] ?? '',
        title: map['title'] ?? '',
        thumb: map['thumb'] ?? '',
        channel: map['channel'] ?? '',
      );
    }
  }

}
