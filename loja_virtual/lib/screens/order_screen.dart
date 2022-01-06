import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;

  const OrderScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmed Order"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 211, 118, 130),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 70,
            ),
            Text("Order confirmed successfully!"),
            Text("Order Code: ${orderId}"),
          ],
        ),
      ),
    );
  }
}
