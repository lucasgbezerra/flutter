import 'package:flutter/material.dart';
import 'package:store_manager_app/widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.store,
                color: Theme.of(context).primaryColorLight,
                size: 160,
              ),
              const InputField(
                icon: Icons.person_outline,
                hint: "User",
                obscuretext: false,
              ),
              const InputField(
                icon: Icons.lock_outline,
                hint: "Password",
                obscuretext: true,
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    // minimumSize: Size(sizeScreen.width, 50),
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
