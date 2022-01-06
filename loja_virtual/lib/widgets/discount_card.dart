import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Colors.grey[700],
      title: Text(
        "Promo Code",
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
      leading: Icon(Icons.card_giftcard),
      trailing: Icon(Icons.add),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter your Promo Code"),
            initialValue: CartModel.of(context).couponCode ?? "",
            onFieldSubmitted: (text) {
              FirebaseFirestore.instance
                  .collection('coupons')
                  .doc(text)
                  .get()
                  .then((value) {
                if (value.exists) {
                  CartModel.of(context).setCoupon(text, value.get('percent'));
                  ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                    SnackBar(
                      content: Text("Promo Code ${value.get('percent')}% applied!"),
                      duration: Duration(seconds: 2),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                } else {
                  ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(
                    content: Text("Invalid Promo Code",),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                }
              });
            },
          ),
        )
      ],
    );
  }
}
