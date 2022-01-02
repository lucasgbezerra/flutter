import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Colors.grey[700],
      title: Text(
        "Calcular Frete",
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
      leading: Icon(Icons.location_on),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Digite seu CEP"),
            onFieldSubmitted: (text) {
            },
          ),
        )
      ],
    );
  }
}
