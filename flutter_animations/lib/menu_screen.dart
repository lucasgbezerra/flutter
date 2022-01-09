import 'package:flutter/material.dart';
import 'package:flutter_animations/heart_screen.dart';
import 'package:flutter_animations/plant_grow.dart';
import 'package:flutter_animations/star_spinning.dart';
import 'package:rive/rive.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        padding: EdgeInsets.all(8.0),
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HeartScreen()));

            },
            child: Container(
              color: Colors.white,
              child: RiveAnimation.asset('assets/heart_animations.riv',),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => StarSpinning()));
            },
            child: Container(
              child: RiveAnimation.asset('assets/star_spinning.riv', animations: ['Spinning']),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlantGrow()));

            },
            child: Container(
              child: RiveAnimation.asset('assets/tree_grow.riv', animations: ['Example'],),
            ),
          ),
        ],
      ),
    );
  }
}
