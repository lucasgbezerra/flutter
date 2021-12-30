import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(this.snapshot, {Key? key}) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    //Screen com uma tab bar definindo duas organizações
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.get('title')),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 211, 118, 130),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          // Query snapshot: "fotográfia" de uma coleção
          // Documents snapshot: "fotográfia" de um documento
          body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('produtos')
                  .doc(snapshot.id)
                  .collection('items')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return TabBarView(children: [
                    GridView.builder(
                        padding: EdgeInsets.all(4),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            crossAxisCount: 2,
                            childAspectRatio: 0.65),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductData data = ProductData.fromDocument(
                              snapshot.data!.docs[index]);
                          data.category = this.snapshot.id;
                          return ProductTile("grid", data);
                        }),
                    ListView.builder(
                      padding: EdgeInsets.all(4),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductData data = ProductData.fromDocument(
                            snapshot.data!.docs[index]);
                        data.category = this.snapshot.id;
                        return ProductTile("list", data);
                      },
                    )
                  ]);
              })),
    );
  }
}
