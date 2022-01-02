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
        "Cupom de Desconto",
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
                border: OutlineInputBorder(), hintText: "Digite seu cupom"),
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
                      content: Text("Cupom de ${value.get('percent')}% aplicado!"),
                      duration: Duration(seconds: 2),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                } else {
                  ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(
                    content: Text("Cupom Inválido",),
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
