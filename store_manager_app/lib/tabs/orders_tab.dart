import 'package:flutter/material.dart';
import 'package:store_manager_app/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return OrderTile();
          },
        ),
      ),
    );
  }
}