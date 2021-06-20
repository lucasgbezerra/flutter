import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductTab extends StatelessWidget {
  const ProductTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('produtos').get(),
      builder: (context, snapshot){
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        else{
          // Tiles com divisão
          var dividedTiles = ListTile.divideTiles(
            tiles: snapshot.data!.docs.map(
              (doc){
               return CategoryTile(doc);
              }
            ).toList(),
            color: Colors.grey).toList();
          return ListView(
            children: dividedTiles
          );
        }
      }
    );
  }
}