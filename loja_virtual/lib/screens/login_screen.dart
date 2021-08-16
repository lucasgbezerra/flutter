import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:loja_virtual/widgets/password_field_widget.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
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
      body: Form(
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
              PasswordFieldWidget(),
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
      ),
    );
  }
}
