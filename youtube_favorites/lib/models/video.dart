import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
    };
  }


  String toJson() => json.encode(toMap());

  factory Video.fromJson(Map<String, dynamic> map) {
    return Video(
      id: map['id']['videoId'] ?? '',
      title: map['snippet']['title'] ?? '',
      thumb: map['snippet']['thumbnails']['high']['url'] ?? '',
      channel: map['snippet']['channelTitle'] ?? '',
    );
  }
}
