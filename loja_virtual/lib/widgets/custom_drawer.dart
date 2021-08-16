import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';

// Widget de tela lateral
class CustomDrawer extends StatelessWidget {
  PageController pageController;

  CustomDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {

    //Função anonima cria um degradê na tela
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 211, 118, 130),
          Colors.white
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
        )
      ),
    );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5.0), //Espaçamento por fora
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Flutter's\nStore", style: TextStyle(
                      fontSize: 34.0, fontWeight: FontWeight.bold),)
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Olá,", style: TextStyle(fontSize: 18.0, 
                          fontWeight: FontWeight.bold)),
                          GestureDetector( // Texto clicavél
                            child: Text("Entre ou cadastre-se >", style: TextStyle(fontSize: 16.0, 
                            fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                            },
                          )],
                      )
                    )],
                ),
              ),
              //Divide a list view com um espaço
              Divider(),
              DrawerTile(Icons.home, "Home", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          )
        ],),
    );
  }
}