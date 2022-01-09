import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

// Uso de State Machine, controla o crescimento com um input dado apartir do tempo
class PlantGrow extends StatefulWidget {
  const PlantGrow({Key? key}) : super(key: key);

  @override
  State<PlantGrow> createState() => _PlantGrowState();
}

class _PlantGrowState extends State<PlantGrow> {
  String _buttonText = "Plant";
  late Timer _timer;
  int _treeProgress = 0;
  int _treeMaxProgress = 60;

  Artboard? _riveArtboard;
  SMIInput<double>? _progress;
  StateMachineController? _treeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rootBundle.load('assets/tree_grow.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, 'sm_grow');
      if (controller != null) {
        artboard.addController(controller);
        _progress = controller.findInput('input');
        setState(() {
          _riveArtboard = artboard;
        });
      }
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_treeMaxProgress == _treeProgress) {
        stopTimer();
        _buttonText = "Plant";
        _treeProgress = 0;
        _treeMaxProgress = 60;
      } else {
        setState(() {
          _treeProgress++;
          _progress?.value = _treeProgress.toDouble();
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Plant Grow", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.green[900],
        elevation: 0,
      ),
      backgroundColor: Colors.green[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: width - 40,
              width: width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width - 40 / 2),
                border:
                    Border.all(color: Colors.white.withOpacity(0.2), width: 5),
              ),
              child: _riveArtboard == null
                  ? SizedBox()
                  : Rive(
                      artboard: _riveArtboard!,
                      alignment: Alignment.center,
                    ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            "${(_treeMaxProgress - _treeProgress).toString()} s",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          TextButton(
              style: TextButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.green,
                minimumSize: Size(width / 2, 40),
              ),
              onPressed: () {
                if (_treeProgress > 0) {
                  stopTimer();
                  _buttonText = "Plant";
                  _treeProgress = 0;
                  _treeMaxProgress = 60;
                } else {
                  _buttonText = "Surrender";
                  startTimer();
                }
              },
              child: Text(
                _buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ))
        ],
      ),
    );
  }
}
