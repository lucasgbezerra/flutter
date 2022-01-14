import 'package:flutter/material.dart';
import 'package:flutter_animations_2/screens/login/widgets/input_field.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          children: const [
            InputField(
              icon: Icons.person_outline,
              hint: "Username",
              obscuretext: false,
            ),
            InputField(
              icon: Icons.lock_outline,
              hint: "Password",
              obscuretext: true,
            ),
          ],
        ),
      ),
    );
  }
}
