import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot category;
  const CategoryTile(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.network(
              category.get('image'),
            ),
          ),
          title: Text(
            category.get('title'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            FutureBuilder<QuerySnapshot>(
                future: category.reference.collection('items').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.network("${doc.get('images')[0]}"),
                          ),
                          title: Text("${doc.get('title')}", ),
                          trailing: Text("\$${doc.get('price').toStringAsFixed(2)}"),
                          onTap: (){},
                        );
                      }).toList()..add(ListTile(
                        title: Text("Add",),
                        leading: Icon(Icons.add, color: Theme.of(context).primaryColor,),
                        onTap: (){

                        },
                      )),
                    );
                  }
                }),
          ]),
    );
  }
}
