import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController =  TextEditingController();
  TextEditingController heightController =  TextEditingController();
  String _infoText = "Informe seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc;

      imc = weight/(height*height);
      print(imc);
      if(imc <=18.5){
        _infoText = "Magreza (${imc.toStringAsPrecision(3)})";
      } else if((imc <=24.9) && (imc>18.5)) {
        _infoText = "Normal (${imc.toStringAsPrecision(3)})";
      }else if((imc <= 29.9) && (imc > 24.9)){
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      }else if((imc <= 30.0) && (imc > 39.9)){
        _infoText = "Obesidade (${imc.toStringAsPrecision(3)})";
      }else{
        _infoText = "Obesidade grave(${imc.toStringAsPrecision(3)})";
      }
    });

  }
  void _resetField(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 2, 87, 34),
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetField)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person,size: 100, color: Color.fromRGBO(66, 3, 138, 54),),
              TextFormField(keyboardType:  TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Color.fromRGBO(137, 69, 2014, 84)),),
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(41, 2, 87, 34), fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(keyboardType:  TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Color.fromRGBO(137, 69, 2014, 84)),),
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(41, 2, 87, 34), fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top:10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(onPressed: (){
                    if(_formKey.currentState.validate()){
                      _calculate();
                    }
                  },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    color: Color.fromRGBO(41, 2, 87, 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
              Text(_infoText, textAlign: TextAlign.center,
                style: TextStyle(color:Color.fromRGBO(66, 3, 138, 54), fontSize: 20.0),
              )
            ],
          ),
        ),
      )
    );
  }
}
