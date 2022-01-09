import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HeartScreen extends StatefulWidget {
  HeartScreen({Key? key}) : super(key: key);

  @override
  State<HeartScreen> createState() => _HeartScreenState();
}

class _HeartScreenState extends State<HeartScreen> {
  late RiveAnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = OneShotAnimation('Animation 1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Heart'),
          centerTitle: true,
          backgroundColor: Colors.red[700],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Center(
                  child: RiveAnimation.asset(
                    'assets/heart_animations.riv',
                    controllers: [controller],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      iconSize: 40,
                      onPressed: () {
                        if (controller.isActive == false) {
                          setState(() {
                            controller.isActive = true;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.red,
                      )),
                  IconButton(
                      iconSize: 40,
                      onPressed: () {
                        if (controller.isActive == true) {
                          setState(() {
                            controller.isActive = false;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.pause,
                        color: Colors.blue,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
