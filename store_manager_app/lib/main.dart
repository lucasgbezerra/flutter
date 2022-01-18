import 'package:flutter/material.dart';
import 'package:store_manager_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Store manager',
        theme: ThemeData(
          primaryColor: const Color(0xFF6320EE),
          primaryColorLight: const Color(0xFF8075FF),
          backgroundColor: const Color(0xFF616161),
        ),
        home: LoginScreen());
  }
}
