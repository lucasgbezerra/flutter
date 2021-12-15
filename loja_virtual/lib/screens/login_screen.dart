import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:loja_virtual/widgets/password_field_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
              style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@"))
                        return "E-mail inválido!";
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email), hintText: "Email"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  PasswordFieldWidget(
                    controller: _passwordController,
                    validator: (value) => value!.isEmpty ? "Campo vazio" : null,
                  ),
                  Align(
                    heightFactor: 2,
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (_emailController.text.isEmpty){
                          ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                            SnackBar(
                              content: Text("O campo não pode estar vazio, adicione um email para recuperação"),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }else{
                          model.recoverPassword(email: _emailController.text);
                           ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                            SnackBar(
                              content: Text("Email enviado, confira seu email!"),
                              duration: Duration(seconds: 2),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Esqueci a senha",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: ElevatedButton(
                      onPressed: () {
                        //Validando os campos do forms
                        if (_formKey.currentState!.validate())
                          model.signIn(
                              email: _emailController.text,
                              password: _passwordController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                      },
                      child: Text(
                        "Entrar",
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
        content: Text("Falha ao tentar logar"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }
}
