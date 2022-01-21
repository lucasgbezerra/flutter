import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:store_manager_app/bloc/user_bloc.dart';

class OrderHeader extends StatelessWidget {
  final DocumentSnapshot order;

  const OrderHeader(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.getBloc<UserBloc>();

    final _user = _userBloc.getUsers(order.get('clientId'));
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${_user['name']}"),
                Text("${_user['email']}"),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Products: \$${(order.get('totalPrice') - order.get('shipPrice')).toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text("Total: \$${order.get('totalPrice').toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}
