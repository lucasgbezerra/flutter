import 'dart:convert';
import 'package:buscador_de_gif/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getgifs() async {
    http.Response response;

    if (_search == null || _search.isEmpty) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=eup3xIeY4k1xZMUeUQXJ9VQ4YbyvwFTv&limit=26&rating=g");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=eup3xIeY4k1xZMUeUQXJ9VQ4YbyvwFTv&q=$_search&limit=25&offset=$_offset&rating=g&lang=en");
    }
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  labelText: "Search"),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(future: _getgifs(),
                builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                return Container(
                    width: 150.0,
                    height: 150.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                    ),
                  );
                default:
                  {
                    if (snapshot.hasError) {
                      return  Container(color: Colors.purpleAccent,); //provisório
                    } else {
                      return _createGifTable(context, snapshot);
                    }
                  }
              }
            }),
          )
        ],
      ),
    );
  }
  int _countGifs(List data){
    if (_search ==null || _search.isEmpty){
      return data.length;
    }else{
      return data.length +1 ;
    }
  }
  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(5.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5.0, crossAxisCount: 2, crossAxisSpacing: 5.0),
        itemCount:  _countGifs(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if(_search ==null || _search.isEmpty || index < snapshot.data["data"].length) {
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data["data"][index]["images"]["fixed_width_still"]["url"],
                height: 300.0,
              ),
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index])
                ));
            },
              onLongPress: (){
                Share.share(snapshot.data["data"][index]["images"]["fixed_width_still"]["url"]);
              },
            );
          }else{
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white,size: 50.0,),
                  Text("More Gifs", style: TextStyle(color: Colors.white, fontSize: 20.0),)
                ],
              ),
                  onTap: (){
                setState(() {
                  _offset+=25;
                });
            },
              );
          }
        });
  }
}
