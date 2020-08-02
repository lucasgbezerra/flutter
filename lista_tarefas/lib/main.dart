import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];
  final _toDoController = TextEditingController();
  Map<String, dynamic> itemRemoved = Map();
  int itemRemovedPos;

  @override
  void initState() {
    super.initState();
    //sobreescrevendo o metodo de inicializão para buscar o arquivo e recarregalo no app
    _readFile().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }
 Future<Null> _refresh() async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _toDoList.sort((a,b){
        if(a["ok"] && !b["ok"]){
          return 1;
        }else if(!a["ok"] && b["ok"]){
          return -1;
        }else {
          return 0;
        }
        _saveFile();
      });
    });
    return null;
  }
  void _addToDo() {
    Map<String, dynamic> newToDo = Map();
    setState(() {
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 10.0, 10.0, 7.0),
              child: Row(
                children: [
                  Expanded(
                    child: //Delimita o TextField ao máximo possível
                        TextField(
                      decoration: InputDecoration(
                          labelText: "Nova tarefa",
                          labelStyle: TextStyle(color: Colors.deepPurple)),
                      controller: _toDoController,
                    ),
                  ),
                  RaisedButton(
                    onPressed: _addToDo,
                    child: Text("Add"),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
            Expanded(
                child: RefreshIndicator(onRefresh: _refresh,
            child:  ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _toDoList.length, //tamanho da lista
                itemBuilder: itemBuild)),
            )
          ],
        ));
  }

  Widget itemBuild(BuildContext context, int index) {
    return Dismissible(key: Key(DateTime.now().microsecondsSinceEpoch.toString() ),
        background: Container(
          color: Colors.redAccent,
          child: Align(
            alignment: Alignment(-0.9,0), //alinhamento vai de -1 a 1, 0 é o centro
            child: Icon(Icons.delete, color: Colors.white),
          )
        ),
        direction: DismissDirection.startToEnd,
        child: CheckboxListTile(
          //criar elementos da lista, contexto, num do elemento na lista
            title: Text(_toDoList[index]["title"]),
            value: _toDoList[index]["ok"],
            secondary: CircleAvatar(//Adciona um circulo em volta do icon
              child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
              backgroundColor: _toDoList[index]["ok"] ? Colors.green : Colors.red,
            ),
            onChanged: (check) {
              setState(() {
                _toDoList[index]["ok"] = check;
                _saveFile();
              });}),
        onDismissed: (direction){//cada direção pode realizar uma tarefa
      setState(() {
        itemRemovedPos = index;
        itemRemoved = Map.from(_toDoList[index]);
        _toDoList.removeAt(index);
        _saveFile();
      });
      final snackBar = SnackBar(
        content: Text("Tarefa \"${itemRemoved['title']}\" removida!"),
        action: SnackBarAction(label: 'Desfazer', onPressed: (){
          setState(() {
            _toDoList.insert(itemRemovedPos, itemRemoved);
            _saveFile();
          });
        }),
        duration: Duration(seconds: 2) ,
      );
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(snackBar);

        },
    );

  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveFile() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readFile() async {
    //Pegar o arquivo que vem do getFile() e retorna uma string
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null; //Provisório, deve ter algum tratamento melhor do erro
    }
  }
}
