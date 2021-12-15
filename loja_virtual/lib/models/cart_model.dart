import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<CartProduct> products = [];

  UserModel user;

  CartModel(this.user);

  addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.copyWith(cid: doc.id);
    });

    notifyListeners();
  }

  removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance.collection('users').doc(user.firebaseUser!.uid).collection('cart').doc(cartProduct.cid).delete();

    products.remove(cartProduct);
    notifyListeners();
  }
}
