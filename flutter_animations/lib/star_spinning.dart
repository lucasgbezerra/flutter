import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class StarSpinning extends StatefulWidget {
  const StarSpinning({Key? key}) : super(key: key);

  @override
  State<StarSpinning> createState() => _StarSpinningState();
}

class _StarSpinningState extends State<StarSpinning> {
  Artboard? _riveArtboard;
  SMIInput<bool>? _pressed;
  StateMachineController? _controller;
  late int count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = 0;

    rootBundle.load('assets/star_spinning.riv').then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, 'sm_star');
      if (controller != null) {
        artboard.addController(controller);
        _pressed = controller.findInput('Pressed');
        setState(() => _riveArtboard = artboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Spinning'),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Number of jumps: ${count.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Container(
              height: 200,
              width: 200,
              child: _riveArtboard == null
                  ? SizedBox()
                  : Rive(
                      artboard: _riveArtboard!,
                      alignment: Alignment.center,
                    )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          setState(() {
            count++;
            _pressed?.value = true;
          });
        },
      ),
    );
  }
}
