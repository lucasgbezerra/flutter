import 'package:flutter/material.dart';
import 'package:youtube_favorites/delegates/data_search.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
            onPressed: () async{
              String result = await showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container()
    );
  }
}
