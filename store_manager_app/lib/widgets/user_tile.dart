import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserTile(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textStyle = const TextStyle(color: Colors.white);
    if (user.containsKey('moneySpended')) {
      return ListTile(
        title: Text(
          user["name"],
          style: _textStyle,
        ),
        subtitle: Text(
          user["email"],
          style: _textStyle,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Orders: ${user["orders"]}",
              style: _textStyle,
            ),
            Text(
              "Spent: ${user["moneySpended"]}",
              style: _textStyle,
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: 100,
              // Shimmer é um package do efeito de cintilar para carregamento
              child: Shimmer.fromColors(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 4),
                  ),
                  baseColor: Color(Colors.grey[300]!.value),
                  highlightColor: Color(Colors.grey[100]!.value)),
            ),
            SizedBox(
              height: 20,
              width: 150,
              // Shimmer é um package do efeito de cintilar para carregamento
              child: Shimmer.fromColors(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 4),
                  ),
                  baseColor: Color(Colors.grey[300]!.value),
                  highlightColor: Color(Colors.grey[100]!.value)),
            )
          ],
        ),
      );
    }
  }
}
