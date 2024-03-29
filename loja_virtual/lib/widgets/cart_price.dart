import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback onPressed;
  const CartPrice({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double subtotal = model.getProductsPrice();
            double shipment = model.getShipPrice();
            double discount = model.getDiscount();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sub Total"),
                    Text("\$ ${subtotal.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount"),
                    Text("\$ ${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping"),
                    Text("\$ ${shipment.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$ ${(subtotal + discount + shipment).toStringAsFixed(2)}",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                    child: Text("Checkout"),
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 211, 118, 130),
                      minimumSize: Size.fromHeight(40)
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
