import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class CategoriesTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>( //Tela das categorias/produtos
      future: Firestore.instance.collection('categories').getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }else{
          var divideTiles = ListTile.divideTiles( //Linha divisorria entre as tiles
              tiles: snapshot.data.documents.map(  //Variavel sem tipo definido
                  (doc){
                return CategoryTile(doc);
              }).toList(),
            color: Colors.grey.shade500
          ).toList();

          return ListView(
            children: divideTiles,
          );
        }
      },
    );
  }
}
