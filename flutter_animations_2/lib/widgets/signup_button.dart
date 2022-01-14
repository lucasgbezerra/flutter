import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 160),
      child: TextButton(
        child: const Text(
          "Click here for sign up!",
          textAlign: TextAlign.center,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
