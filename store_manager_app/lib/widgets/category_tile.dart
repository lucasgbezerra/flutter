import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_manager_app/screens/product_screen.dart';
import 'package:store_manager_app/widgets/edit_category_dialog.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot category;
  const CategoryTile(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: ExpansionTile(
          leading: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => EditCategoryDialog(
                        category: category,
                      ));
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.network(
                category.get('image'),
              ),
            ),
          ),
          title: Text(
            category.get('title'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: category.reference.collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: doc.get('images').length != 0 ? Image.network("${doc.get('images')[0]}") : const Icon(Icons.image),
                          ),
                          title: Text(
                            "${doc.get('title')}",
                          ),
                          trailing:
                              Text("\$${doc.get('price').toStringAsFixed(2)}"),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                    categoryId: category.id, product: doc),
                              ),
                            );
                          },
                        );
                      }).toList()
                        ..add(ListTile(
                          title: const Text(
                            "Add",
                          ),
                          leading: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreen(categoryId: category.id),
                              ),
                            );
                          },
                        )),
                    );
                  }
                }),
          ]),
    );
  }
}
