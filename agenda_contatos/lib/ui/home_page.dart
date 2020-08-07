import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';

enum OrderOptions { ordenarAZ, ordenarZA } //conjunto de constantes

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper =
      ContactHelper(); //Como a classe ta definida como Singleton,
  // mesmo que se instanciace 2 vezes aqui apenas um obejto seria criado
  List<Contact> contacts = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Contatos"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: [
            PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem(
                  child: Text("Ordenar de A-Z"),
                  value: OrderOptions.ordenarAZ,
                ),
                const PopupMenuItem(
                  child: Text("Ordenar de A-Z"),
                  value: OrderOptions.ordenarAZ,
                )
              ],
              onSelected: _orderList,
            ),]
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        focusColor: Colors.white,
        child: Icon(Icons.add, size: 30.0),
        onPressed: () {
          _showContactPage();
        },
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _cardContactBuilder(context, index);
          }),
    );
  }

  Widget _cardContactBuilder(context, index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                //imagem no formato redondo
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contacts[index].img != null
                            ? FileImage(File(contacts[index].img))
                            : AssetImage("images/user.png"),
                      fit: BoxFit.cover
                    )),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contacts[index].name ?? "",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contacts[index].email ?? "",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        contacts[index].phone ?? "",
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      onTap: () {
        _showOpitions(context, index);
      },
    );
  }

  void _showContactPage({Contact contact}) async {
    //Passa o contato quando param quando for editar
    final recContact = await Navigator.push(
        //Espera até a pagina ser fechada para receber
        context,
        MaterialPageRoute(
            //o contato novo ou modificado
            builder: (context) => ContactPage(contact: contact)));

    if (recContact != null) {
      //Algo foi criado ou alterado
      if (contact != null) {
        //Passou um contato como param, ou seja, editou algo
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts(); //Para reexibir os a lista com o "novo" contato
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  void _showOpitions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            launch("tel: ${contacts[index].phone}");
                          },
                          child: Text(
                            "Ligar",
                            style:
                                TextStyle(color: Colors.green, fontSize: 15.0),
                          )),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showContactPage(contact: contacts[index]);
                          },
                          child: Text(
                            "Editar",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 15.0),
                          )),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            helper.deleteContact(contacts[index].id);
                            setState(() {
                              contacts.removeAt(index);
                            });
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ))
                    ],
                  ),
                );
              });
        });
  }

  _orderList(OrderOptions result) {
    switch(result){
      case OrderOptions.ordenarAZ:
        contacts.sort((a,b){
         return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.ordenarZA:
        contacts.sort((a,b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }
}
