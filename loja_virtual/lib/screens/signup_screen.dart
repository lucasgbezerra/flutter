import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/widgets/password_field_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Sign up"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) return "Invalid name!";
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person), hintText: "Name"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@"))
                        return "Invalid Email address!";
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email), hintText: "Email address"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  PasswordFieldWidget(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.length < 7)
                        return "Password must be at least 7 characters.";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  PasswordFieldWidget(
                    hint: "Re-enter password",
                    controller: _passConfirmController,
                    validator: (value) {
                      if (value!.compareTo(_passwordController.text) != 0)
                        return "Password must match!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        //Validando os campos do forms
                        if (_formKey.currentState!.validate()) {
                          model.signUp(
                              userData: {
                                "name": _nameController.text,
                                "email": _emailController.text,
                              },
                              password: _passwordController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                      child: Text(
                        "Create account",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  void _onFail() {
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        content: Text("Unable to create account!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _onSuccess() {
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso"),
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context).pop();
    });
  }
}
