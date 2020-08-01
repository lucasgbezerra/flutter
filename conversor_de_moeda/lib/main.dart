import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=010400f0";

void main() async {
  runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
      hintColor: Color.fromRGBO(18, 255, 89, 100),
      primaryColor: Colors.white, inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color:  Colors.white,)),
        focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color:
          Color.fromRGBO(18, 255, 89, 100))),
          hintStyle: TextStyle(color: Color.fromRGBO(18, 255, 89, 100))
      )
  ),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body); // chamar como await getData()
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar;
  double euro;
  double pound;

  final realControler = TextEditingController();
  final dollarControler = TextEditingController();
  final euroControler = TextEditingController();
  final poundControler = TextEditingController();

  _realChange(String text){
    double real = double.parse(text);
    dollarControler.text = (real/dollar).toStringAsFixed(2);
    euroControler.text = (real/euro).toStringAsFixed(2);
    poundControler.text = (real/pound).toStringAsFixed(2);
  }
  _dollarChange(String text){
    double dollar = double.parse(text);

    realControler.text = (dollar * this.dollar).toStringAsFixed(2);
    euroControler.text = ((dollar * this.dollar)/euro).toStringAsFixed(2);
    poundControler.text = ((dollar * this.dollar)/pound).toStringAsFixed(2);
  }
  _euroChange(String text){
    double euro = double.parse(text);

    realControler.text = (euro * this.euro).toStringAsFixed(2);
    dollarControler.text = ((euro * this.euro)/dollar).toStringAsFixed(2);
    poundControler.text = ((euro * this.euro)/pound).toStringAsFixed(2);
  }
  _poundChange(String text){
    double pound = double.parse(text);

    realControler.text = (pound * this.pound).toStringAsFixed(2);
    dollarControler.text = ((pound * this.pound)/dollar).toStringAsFixed(2);
    euroControler.text = ((pound * this.pound)/euro).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(18, 255, 89, 100),
        title: Text("Conversor \$"),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          //função anonima com 2 param
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Obtendo dados ...",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color.fromRGBO(18, 255, 89, 100),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Ocorreu um erro ao obter os dados :(",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(18, 255, 89, 100),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }else{
                dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                pound = snapshot.data["results"]["currencies"]["GBP"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Icon(Icons.monetization_on, size: 100,color: Color.fromRGBO(18, 255, 89, 100)),
                      builderTextField("Reais","R\$", realControler, _realChange),
                      Divider(),
                      builderTextField("Dólares","US\$", dollarControler, _dollarChange),
                      Divider(),
                      builderTextField("Euros","€", euroControler, _euroChange),
                      Divider(),
                      builderTextField("Libras Esterlinas","£", poundControler, _poundChange)
                    ],
                  )
                );
              }
          }
        },
      ),
    );
  }
}

Widget builderTextField(String label, String prefix, TextEditingController textController, Function textChange){ //Otimizando o código
  return TextField(decoration: InputDecoration(labelText: label,
      labelStyle: TextStyle(color: Colors.white ),
      border: OutlineInputBorder(), prefixText: prefix,
      prefixStyle:TextStyle(color:Color.fromRGBO(18, 255, 89, 100),
          fontWeight: FontWeight.bold, fontSize: 20.0)),
      style: TextStyle(color: Color.fromRGBO(18, 255, 89, 100), fontSize: 20.0),
      controller: textController,
    onChanged: textChange,
    keyboardType: TextInputType.number,
  );
}