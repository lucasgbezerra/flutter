import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/orders_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:store_manager_app/widgets/order_tile.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  
  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.getBloc<OrdersBloc>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
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
      floatingActionButton: _buildFloatingActionButton(_ordersBloc),
    );
  }

  Widget? _buildFloatingActionButton(OrdersBloc _ordersBloc) {
      return SpeedDial(
        icon: Icons.sort,
        backgroundColor: Theme.of(context).primaryColor,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
              label: "Delivereds Last",
              child: Icon(
                Icons.arrow_downward,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Colors.white,
              onTap: () {
                _ordersBloc.setSortCriteria(SortCriteria.DELIVERED_LAST);
              }),
          SpeedDialChild(
              label: "Delivereds First",
              child: Icon(
                Icons.arrow_upward,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Colors.white,
              onTap: () {
                _ordersBloc.setSortCriteria(SortCriteria.DELIVERED_FIRST);
              }),
        ],
      );

  }
}
