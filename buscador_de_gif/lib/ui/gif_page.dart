import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;

  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(_gifData["title"]),
        backgroundColor: Colors.black,
        actions: [
          IconButton(alignment: Alignment.centerRight,icon: Icon(Icons.share),
            onPressed: () {
              Share.share(_gifData["images"]["original"]["url"]);
          })
        ],
      ),
      body: Center(
        child: Image.network(_gifData["images"]["original"]["url"]),
      ),
    );
  }
}
