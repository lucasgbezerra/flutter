import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      title: "Contador de pessoas",
      home: Home() ));
}
// Statefull: Widgets que possuem estado interno modificáveis
// Stateless: Widgets sem estado interno, não mudarão de estado durante a execução, ex: texto
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _infoPeople = "Pode entrar!";
  void _changePeople(int delta){//alteravel apenas dentro da class

    setState(() {
      _people += delta;
      if(_people < 0){
        _infoPeople = "WTF";
      } else if(_people <= 10){
        _infoPeople = "Pode entrar!";
      }else {
        _infoPeople = "Lotado!";
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/space.jpg", height: 1000,
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Pessoas: $_people",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                        child: Text("-",
                            style: TextStyle(
                                color: Colors.green, fontSize: 50.0)),
                        onPressed: () {
                          _changePeople(-1);
                        } //funçao anonima,
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                        child: Text("+",
                            style:
                            TextStyle(color: Colors.red, fontSize: 50.0)),
                        onPressed: () {
                          _changePeople(1);
                        } //funçao anonima,
                    )),
              ],
            ),
            Text("$_infoPeople",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0,
                    color: Colors.white)),
          ],
        )
      ],
    );
  }
}
