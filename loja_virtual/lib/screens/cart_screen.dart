import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/screens/order_screen.dart';
import 'package:loja_virtual/tiles/cart_product_tile.dart';
import 'package:loja_virtual/widgets/cart_price.dart';
import 'package:loja_virtual/widgets/discount_card.dart';
import 'package:loja_virtual/widgets/ship_cart.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 10),
              child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
                  int qtd = model.products.length;

                  return Text(
                    "${qtd == null ? 0 : qtd} ${qtd == 1 ? "ITEM" : "ITENS"}",
                    style: TextStyle(fontSize: 17),
                  );
                },
              ))
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (UserModel.of(context).isLoggedIn() && model.isLoading) {
            // Carregando produtos no carrinho
            return Center(child: CircularProgressIndicator());
          } else if (!UserModel.of(context).isLoggedIn()) {
            // Usuário não logado
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Sign In to view itens in cart.",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text("Sign In"),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: Size(double.maxFinite, 40)),
                  )
                ],
              ),
            );
          } else if (model.products.length == 0) {
            // Usuário não tem nenhum produto no carrinho
            return Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            // Usuario logado e com produtos no carrinho
            return ListView(
              children: <Widget>[
                Column(
                    children: model.products.map((product) {
                  return CartProductTile(cartProduct: product);
                }).toList()),
                DiscountCard(),
                ShipCard(),
                CartPrice(
                  onPressed: () async {
                    String? orderId = await model.finishOrder();
                    if (orderId != null)
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => OrderScreen(orderId: orderId)));
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
