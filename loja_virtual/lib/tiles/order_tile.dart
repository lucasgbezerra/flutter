import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  const OrderTile(this.orderId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              int status = snapshot.data!.get('status');
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: "Código do pedido: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: snapshot.data!.id,
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ]),
                    ),
                    SizedBox(height: 5),
                    Text(_buildProductText(snapshot.data!)),
                    SizedBox(height: 5),
                    Text(
                      "Status do pedido:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildCircle("1", "Preparação", status, 1),
                          Expanded(child: Divider(color: Colors.black)),
                          _buildCircle("2", "Transporte", status, 2),
                          Expanded(child: Divider(color: Colors.black)),
                          _buildCircle("3", "Entrega", status, 3),
                        ],
                      ),
                    ),
                    Divider()
                  ]);
            }
          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";

    for (LinkedHashMap product in snapshot.get('products')) {
      double price = product['product']['price'];
      text +=
          "${product['quantity']}x ${product['product']['title']} (R\$ ${price.toStringAsFixed(2)})\n";
    }
    double totalPrice = snapshot.get('totalPrice');
    text += "Total: R\$ ${totalPrice.toStringAsFixed(2)}";

    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Widget child;
    Color backgroundColor;

    if (status < thisStatus) {
      child = Text(title, style: TextStyle(color: Colors.white));
      backgroundColor = Colors.grey[500]!;
    } else if (status == thisStatus) {
      backgroundColor = Colors.blue;
      child = Stack(alignment: Alignment.center, children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ]);
    } else {
      backgroundColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(

      children: [
        CircleAvatar(
          radius: 20.0,
          child: child,
          backgroundColor: backgroundColor,
        ),
        Text(subtitle)
      ],
    );
  }
}
