import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isVisible = true;

    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            style:
                TextButton.styleFrom(textStyle: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextFormField(
                decoration: InputDecoration(
                    // Consertar
                    // suffixIcon: GestureDetector(
                    //   child: Icon(_isVisible == true
                    //       ? Icons.visibility_off
                    //       : Icons.visibility),
                    //   onTap: () {
                    //     setState(() {
                    //       _isVisible = !_isVisible;
                    //     });
                    //   },
                    // ),
                    hintText: "Senha"),
                obscureText: _isVisible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
