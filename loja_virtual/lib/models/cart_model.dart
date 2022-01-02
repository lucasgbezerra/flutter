import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<CartProduct> products = [];

  UserModel user;

  bool isLoading = false;
  
  String? couponCode;
  int discountPercentage = 0;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.id;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decCartItem(CartProduct cartProduct) {
    cartProduct.quantity = cartProduct.quantity! - 1;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void incCartItem(CartProduct cartProduct) {
    cartProduct.quantity = cartProduct.quantity! + 1;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .doc(cartProduct.cid).update(cartProduct.toMap());
    notifyListeners();
  }

  void setCoupon(String couponCode, int percent){
    this.couponCode = couponCode;
    this.discountPercentage = percent;
  }

  void _loadCartItems() async{
    QuerySnapshot query =  await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser!.uid)
        .collection('cart').get();
    print(query.size);
    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
    print("CArregou");

  }
}
