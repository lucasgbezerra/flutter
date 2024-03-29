import 'package:flutter/material.dart';
import 'package:store_manager_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  //Inicializar a conexão com o firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Store manager',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 211, 118, 130),
          backgroundColor: const Color(0xFF616161),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen());
  }
}
