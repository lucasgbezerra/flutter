import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gabriel\'s',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff0000EE)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
