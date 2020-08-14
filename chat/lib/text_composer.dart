import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  final Function({String text, File imgFile}) sendMessage;

  TextComposer(this.sendMessage);

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  bool _isComposing = false;
  final TextEditingController _controller = TextEditingController();

  void _resetText(String text){
    widget.sendMessage(text: text);
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.camera_alt),
          onPressed: () async {
            final File imgFile = await ImagePicker.pickImage(source: ImageSource.camera);
            if (imgFile==null) return;
            widget.sendMessage(imgFile: imgFile);
          },
          ),
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
