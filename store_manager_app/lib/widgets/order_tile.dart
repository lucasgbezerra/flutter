import 'package:flutter/material.dart';
import 'package:store_manager_app/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "xxxxxxx",
            style: TextStyle(color: Colors.green),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderHeader(),
                  ListTile(
                    title: Text(
                      "Air Jordan 12",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("sneakers/fasdgdafhdgfhg"),
                    trailing: Text(
                      "2",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Backward",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forward",
                            style: TextStyle(color: Colors.green),
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
