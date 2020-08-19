import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot); //Construtor

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, //Tela que tem duas formas de visualização
        child: Scaffold(
          appBar: AppBar(title: Text(snapshot.data['title']),
          centerTitle: true,
            backgroundColor: Color(0xff00C9FF),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.grid_on, )),
                Tab(icon: Icon(Icons.list, ))
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection('categories').document(snapshot.documentID)
            .collection('items').getDocuments(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(child:CircularProgressIndicator());
              }else{
                return TabBarView(
                    children: [GridView.builder( //Construira conforme necessario, não de uma vez a grid de tiles
                        padding: EdgeInsets.all(4.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, //Qtd de itens na orientação cruzada no caso horizontal
                          mainAxisSpacing: 4.0, crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65 //Razão largura altura
                        ),
                        itemCount: snapshot.data.documents.length, //quantidade de produtos
                        itemBuilder: (context, index){
                          return ProductTile('grid', ProductData.fromDocument(snapshot.data.documents[index]));
                        }),
                      ListView.builder( //Construindo a lista de tiles
                        padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder:(context, index){
                            return ProductTile('list', ProductData.fromDocument(snapshot.data.documents[index]));
                          })]
                );
              }
            }
          )
        )
    );
  }
}
