import 'dart:io';

import 'package:chat/chat_message.dart';
import 'package:chat/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  FirebaseUser _currentUser;
  bool _isLoading= false;
  GlobalKey <ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) { //currentUser recebe um novo User sempre que ocorrer um sing in
      setState(() {
        _currentUser = user;                                  //ou sing out
      });
    });
  }


  final GoogleSignIn _googleSignIn = GoogleSignIn(); //obj de autenticação do google

  Future<FirebaseUser>_getUser() async{
    if(_currentUser != null){
      return _currentUser;
    }
    try{
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn(); //tentativa de sing in
    //transformando o login do google em um login no firebase
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user; //usuario no firebase

      return user;
    }catch(e){
      return null;
    }
  }


  void _sendMessage({String text, File imgFile}) async{

    final FirebaseUser user = await _getUser();

    if(user == null){
      _scaffoldState.currentState.showSnackBar(
          SnackBar(content: Text("Failed to log in. Try again!"),
          backgroundColor: Colors.red,));
    }

    Map<String, dynamic> data = {
      "uid": user.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoUrl,
      'time': Timestamp.now()
    };

    if(imgFile != null){
      StorageUploadTask task = FirebaseStorage.instance.ref().child(user.uid).child(
        DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      setState(() {
        _isLoading = true;
      });

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data["imageUrl"] = url;

      setState(() {
        _isLoading = false;
      });
    }

    if(text != null){
      data["text"] = text;
    }
    Firestore.instance.collection("messages").add(data);//Enviando ao BD
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            Text(_currentUser != null ? '${_currentUser.displayName}':
            'chat'
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          _currentUser != null ? IconButton(icon: Icon(Icons.exit_to_app),
              onPressed: (){
                FirebaseAuth.instance.signOut();
                _googleSignIn.signOut();
                _scaffoldState.currentState.showSnackBar(
                    SnackBar(content: Text("You're log out!"),
                      backgroundColor: Colors.red,));
              }) : Container()
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child:StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("messages").orderBy('time').snapshots(),//Snapshot é um tipo de Stream,
                  builder: (context, snapshot){//apontar para a coleção e sempre que algo mudar atualizar
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> documents = snapshot.data.documents.reversed.toList();
                      return ListView.builder(//Carregara dados conforme necessario
                          itemCount: documents.length,
                          reverse: true,
                          itemBuilder: (context, index){
                            return ChatMessage(documents[index].data,
                              documents[index].data['uid'] == _currentUser?.uid
                            );
                          });
                  }
                })
          ),
        _isLoading ? LinearProgressIndicator(): Container(),
        TextComposer(
        _sendMessage)
        ],
      )
    );
  }
}
