import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isNotEmpty) query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(const Duration(seconds: 0))
        .then((_) => close(context, query));

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder<List>(
          future: sugestions(query),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.search),
                      title: Text(snapshot.data![index]),
                      onTap: () {
                        close(context, snapshot.data![index]);
                      },
                    );
                  });
            }
          });
    } else {
      return Container(color: Colors.transparent);
    }
  }

  Future<List> sugestions(String search) async {
    http.Response response = await http.get(Uri.parse(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"));

    if (response.statusCode == 200) {
      return json.decode(response.body)[1].map((sug) => sug[0]).toList();
    } else {
      throw Exception("Failed to load suggestions.");
    }
  }
}
