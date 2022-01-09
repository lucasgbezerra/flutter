import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2)).then((_) => Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 100,
        width: 100,
        child: const Center(
          child: RiveAnimation.asset('assets/heart_animations.riv'),
        ),
      ),
    ));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData iconData = Icons.pause;
  late RiveAnimationController _spinningController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _spinningController = OneShotAnimation('Spinning');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          child: RiveAnimation.asset(
            'assets/star_spinning.riv',
            // animations: ['Jump', 'Spinning'],
            controllers: [
              _spinningController,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(iconData),
        onPressed: () {
          if (_spinningController.isActive == true) {
            setState(() {
              _spinningController.isActive = false;
              iconData = Icons.play_arrow;
            });
          }else{
            _spinningController.isActive = true;
            iconData = Icons.pause;
          }
        },
      ),
    );
  }
}
