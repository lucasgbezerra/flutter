import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/orders_bloc.dart';
import 'package:store_manager_app/widgets/order_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot order;
  OrderTile(this.order, {Key? key}) : super(key: key);

  final status = ["", "Packed", "Shipped", "Out for delivery", "Delivered"];

  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.getBloc<OrdersBloc>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          key: Key(order.id),
          initiallyExpanded: order.get('status') == 4 ? false : true,
          title: Text(
            "${order.id.substring(order.id.length - 7)} - ${status[order.get('status')]}",
            style: TextStyle(color: Colors.green),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderHeader(order),
                  Column(
                    children: order.get('products').map<Widget>((product) {
                      return ListTile(
                        title: Text(
                          "${product['product']['title']} ${product['size']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            Text("${product['category']}/${product['pid']}"),
                        trailing: Text(
                          "${product['quantity']}",
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            _ordersBloc.deleteOrder(order.id, order.get('clientId'));
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: order.get('status') > 1
                              ? () {
                                  _ordersBloc.backwardStatus(order);
                                }
                              : null,
                          child: Text(
                            "Backward",
                            style: TextStyle(color:order.get('status') > 1 ? Colors.black : Colors.grey[400]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: order.get('status') < 4
                              ? () {
                                  _ordersBloc.forwardStatus(order);
                                }
                              : null,
                          child: Text(
                            "Forward",
                            style: TextStyle(color: order.get('status') < 4 ?Colors.green : Colors.grey[400]),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
