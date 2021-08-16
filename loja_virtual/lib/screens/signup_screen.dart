import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/password_field_widget.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SignupScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                validator: (value){
                  if(value!.isEmpty)
                    return "Nome inválido";
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person), hintText: "Nome"),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty || !value.contains("@"))
                    return "E-mail inválido!";
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email), hintText: "E-mail"),
              ),
              SizedBox(
                height: 16.0,
              ),
              PasswordFieldWidget(),
              SizedBox(
                height: 16.0,
              ),
              PasswordFieldWidget(hint: "Confirmar Senha",),
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
                  child: Text("Criar", style: TextStyle(color: Colors.white),),
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