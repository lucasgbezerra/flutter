import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {
  String? cid;
  String? pid;

  String? category;
  String? size;

  int? quantity;

  ProductData? productData;

  
  CartProduct({
    this.pid,
    this.category,
    this.size,
    this.cid,
    this.quantity,
    this.productData,
  });


  CartProduct.fromDocument(DocumentSnapshot document) {
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
      // "product": productData!.toResumeMap(),
    };

  }

}
