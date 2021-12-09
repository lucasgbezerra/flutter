import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:loja_virtual/widgets/password_field_widget.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignupScreen()));
            },
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
      body: ScopedModelDescendant<UserModel>(builder: (context,  child ,model){
        if(model.isLoading)
          return Center(child: CircularProgressIndicator());
        return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                validator: (value){
                  if(value!.isEmpty || !value.contains("@"))
                    return "E-mail inválido!";
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email), hintText: "Email"),
              ),
              SizedBox(
                height: 16.0,
              ),
              PasswordFieldWidget(controller: _passwordController, validator: (value) => value!.isEmpty ? "Campo vazio" : null,),
              Align(
                heightFactor: 2,
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    
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
                    if(_formKey.currentState!.validate())
                      print("0k");
                  },
                  child: Text("Entrar", style: TextStyle(color: Colors.white),),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      );
      })
    );
  }
}
