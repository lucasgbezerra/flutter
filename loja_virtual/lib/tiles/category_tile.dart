import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  // Category Tile recebe como parametro 1 documento
  const CategoryTile(this.snapshot, { Key? key }) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CategoryScreen(snapshot)));
      },
      //Icone
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.get('image')),),
      title: Text(snapshot.get('title')),
      trailing: Icon(Icons.keyboard_arrow_right),

    );
  }
}