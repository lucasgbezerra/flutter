import 'dart:io';
import 'dart:async';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact}); //Construtor da pagina com um contato opecional
  //pois, será a pagina de criar e editar
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContact;
  bool _userEdited = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.contact == null) {
      //acessando variavel de outra classe
      _editedContact = Contact();
    } else {
      _editedContact =
          Contact.fromMap(widget.contact.toMap()); //Construindo um contado
      //para editar aparti do existente
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact
          .email; //Coloca os dados do contato  a editar no formulario
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () => _requestPop(), //Registrar o usuario tentando sair
        child:Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            _editedContact.name ?? "Novo contato",
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          //Botão Flutuante
            backgroundColor: Colors.red,
            focusColor: Colors.white,
            child: Icon(Icons.save),
            onPressed: () {
              if (_editedContact.name != null &&
                  _editedContact.name.isNotEmpty) {
                Navigator.pop(context, _editedContact);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            }),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              GestureDetector(
                  child: Container(
                    //imagem no formato redondo
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: _editedContact.img != null
                                ? FileImage(File(_editedContact.img))
                                : AssetImage("images/user.png"),
                          fit: BoxFit.cover
                        )
                    ),
                  ),
                onTap: (){
                    _selectImage();
                },
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                onChanged: (text) {
                  //Avisar que ocorreu uma mudança nos dados e pedir confirmação
                  _userEdited = true;
                  setState(() {
                    _editedContact.name = text;
                  });
                },
                controller: _nameController,
                focusNode: _nameFocus,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Phone",
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.black)),
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.phone = text;
                },
                keyboardType: TextInputType.phone,
                controller: _phoneController,
              )
            ],
          ),
        )
        )
    );
  }

  Future<bool>_requestPop() {
    if(_userEdited){
      showDialog(context: context,
      builder: (contex){
        return AlertDialog(
          title: Text("Contact Changed", style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text("Do you want discard you edits?"),
          actions: [
            FlatButton(
              child: Text("Cancel", style: TextStyle(color: Colors.green),),
              onPressed: (){
                Navigator.pop(context);

              },
            ),
            FlatButton(
                child: Text("Discard", style: TextStyle(color: Colors.red),),
                onPressed:  () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                }
            ),
          ],
        );
      });
      return Future.value(false);//Só saira manualmente
    }else{
      return Future.value(true); //Sair automaticamente
    }
  }

  void _selectImage() {
    showModalBottomSheet(context: context, builder: (context){
      return BottomSheet(onClosing: (){},
          builder: (context){
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Icon(Icons.camera, size: 30.0, color: Colors.green,),
                onPressed: (){
                  ImagePicker().getImage(source: ImageSource.camera).then((file) {
                    setState(() {
                      Navigator.pop(context);
                      _editedContact.img = file.path;
                    });
                  });
                },
              ),
              FlatButton(
                child: Icon(Icons.image, size: 30.0, color: Colors.blue,),
                onPressed: (){
                  ImagePicker().getImage(source: ImageSource.gallery).then((file) {
                    setState(() {
                      Navigator.pop(context);
                      _editedContact.img = file.path;
                    });
                  });
                },
              )
            ],
          ),
        );
      });
    });
  }
}
