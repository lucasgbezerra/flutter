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
          title: Text("Cadastrar"),
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
                      if (value!.isEmpty) return "Nome inválido";
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person), hintText: "Nome"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@"))
                        return "E-mail inválido!";
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email), hintText: "E-mail"),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  PasswordFieldWidget(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.length < 7)
                        return "A senha deve ter no mínimo 7 dígitos";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  PasswordFieldWidget(
                    hint: "Confirmar Senha",
                    controller: _passConfirmController,
                    validator: (value) {
                      if (value!.compareTo(_passwordController.text) != 0)
                        return "As senhas não são iguais";
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
                        "Criar",
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
    // _scaffoldKey.currentState?.showSnackBar(
    // SnackBar(
    //   content: Text("Não foi possível criar o usuário!"),
    //   duration: Duration(seconds: 2),
    //   backgroundColor: Colors.red,
    // ),
    // );
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(
      SnackBar(
        content: Text("Não foi possível criar o usuário!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _onSuccess() {
    // _scaffoldKey.currentState?.showSnackBar(
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
