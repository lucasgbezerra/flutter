import 'package:flutter/material.dart';
import 'package:flutter_animations/star_spinning.dart';
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
        .pushReplacement(MaterialPageRoute(builder: (context) => StarSpinning())));
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
