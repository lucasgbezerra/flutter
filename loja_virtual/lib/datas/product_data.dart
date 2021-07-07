import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  String category = "";
  String id = "";
  String title = "";
  String description = "";
  
  List sizes = [];
  List images = [];

  double price = 0;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.reference.id;
    title = snapshot.get('title');
    description = snapshot.get('description');
    sizes = snapshot.get('sizes');
    images = snapshot.get('images');
    price = snapshot.get('price');
    
  }
}