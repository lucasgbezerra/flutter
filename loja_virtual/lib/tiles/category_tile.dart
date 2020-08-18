import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot); //Recendo o arquivo do firebase para montar a tile

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data['icon']),
      ),
      title: Text(snapshot.data['title']),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){

      },
    );
  }
}
