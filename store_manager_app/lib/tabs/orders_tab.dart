import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/orders_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:store_manager_app/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.getBloc<OrdersBloc>();
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: StreamBuilder<List>(
            stream: _ordersBloc.outOrders,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text("No orders found."),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return OrderTile(snapshot.data![index]);
                  },
                );
              }
            }),
      ),
    );
  }
}
