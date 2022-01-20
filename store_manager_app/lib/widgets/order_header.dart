import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nome"),
                Text("Endereço"),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Preço produto",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text("Preço total",
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}
