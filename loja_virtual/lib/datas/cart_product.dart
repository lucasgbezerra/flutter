import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {
  final String cid;
  final String pid;

  final String category;
  final String size;

  final int quantity;

  final ProductData? productData;

  CartProduct({
    required this.cid,
    required this.pid,
    required this.category,
    required this.size,
    required this.quantity,
    this.productData,
  });

  CartProduct copyWith({
    String? cid,
    String? pid,
    String? category,
    String? size,
    int? quantity,
    ProductData? productData,
  }) {
    return CartProduct(
      cid: cid ?? this.cid,
      pid: pid ?? this.pid,
      category: category ?? this.category,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      productData: productData ?? this.productData,
    );
  }

  CartProduct.fromDocument(DocumentSnapshot document, this.cid, this.pid,
      this.category, this.size, this.quantity, this.productData) {
    CartProduct(
      cid: document.id,
      category: document.get('category'),
      size: document.get('size'),
      quantity: document.get('quantity'),
      pid: document.get('pid'),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData!.toResumeMap(),
    };

  }
}
