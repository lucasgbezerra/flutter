import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String id;
  const OrderTile(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              text: "Código do pedido: ",
              style: TextStyle(fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                    text: id, style: TextStyle(fontWeight: FontWeight.normal))
              ])),
          Divider()
        ],
      ),
    ));
  }
}
