import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  Function(String) sendMessage;

  TextComposer(this.sendMessage);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  bool _isComposing = false;
  final TextEditingController _controller = TextEditingController();

  void _resetText(String text){
    widget.sendMessage(text);
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: (){}, icon: Icon(Icons.camera_alt),),
          Expanded(
              child: TextField( decoration: InputDecoration.collapsed(hintText: "Type a message"),
                controller: _controller,
                onChanged: (text){
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
                },
                onSubmitted: (text){
                  _resetText(text);
                },
          )),
          IconButton(icon: Icon(Icons.send),
             onPressed: _isComposing ? (){ //Caso esteja digitando a função onpresses é ativada
              _resetText(_controller.text);
              } : null)
        ],
      ),
    );
  }
}
