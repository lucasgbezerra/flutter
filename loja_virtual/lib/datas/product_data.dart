// Class para carregar os dados, é sempre bom que seja separado do código

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  String category;
  String id;
  String title;
  String description;

  double price;

  List images;
  List sizes;
  ProductData.fromDocument(DocumentSnapshot snapshot){
    id =snapshot.documentID;
    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = snapshot.data['price'] + 0.0; //forçará o preço a ser um double
    images = snapshot.data['images'];
    sizes = snapshot.data['size'];
  }


}