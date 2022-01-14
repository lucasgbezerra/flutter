import 'package:flutter/material.dart';
import 'package:flutter_animations_2/widgets/form_container.dart';
import 'package:flutter_animations_2/widgets/signup_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/background.jpg"),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Image.asset(
                        "images/tickicon.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  
                    const FormContainer(),
                    const SignupButton(),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
