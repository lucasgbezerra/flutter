import 'package:flutter/material.dart';
import 'package:flutter_animations_2/screens/home/widgets/list_data.dart';

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> listSlidePosition;
  const AnimatedListView({Key? key, required this.listSlidePosition})
      : super(key: key);

  List<Widget> _listDatabuild(BuildContext context) {
    int numberTiles = 10;
    List<Widget> listData = [];

    while (numberTiles-- > 0) {
      listData.add(ListData(
        title: "List Data Example $numberTiles",
        subTitle: "It's just a random text",
        image: const AssetImage('images/profile.jpg'),
        margin: listSlidePosition.value * numberTiles.toDouble(),
      ));
    }
    return listData;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter, children: _listDatabuild(context));
  }
}
