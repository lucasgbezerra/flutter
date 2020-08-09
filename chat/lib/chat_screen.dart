import 'package:chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void _sendMessage(String text){
    Firestore.instance.collection("messages").add(
      {"texto": text} //Enviando ao BD
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            Text("Nome do Contato")
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: TextComposer(
        _sendMessage
      )
    );
  }
}
