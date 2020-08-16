import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController); //Construtor de um controlador para mudar de paginas pelo drawer

  Widget _buildDraweBackground() => Container( //Criando degradê por tras das imagens
    decoration: BoxDecoration(
        gradient: LinearGradient(//degrade linear
            colors: [
              Color(0xff00C9FF),//cores
              Colors.white,
            ],
            begin: Alignment.topCenter,//inicio e fim
            end: Alignment.bottomCenter
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          _buildDraweBackground(),
          ListView( //Lista dos componentes da drawer
            padding: EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
            children: [
              Container(
                height: 170.0,
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 8.0),
                child: Stack( //Permite posicionar os componentes mais livremente
                  children: [
                    Positioned( //define a posição de um children de um stack
                      top: 8.0, left: 0.0,
                        child: Text('Gabriel\'s', style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        )
                    ),
                    Positioned( //define a posição de um children de um stack
                        bottom: 0.0, left: 0.0,
                        child: Column( // Botão para cadastro
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Olá,', style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                            ),
                           GestureDetector(
                             child: Row(
                               children: [
                                 Text('Entre ou cadastre-se', style: TextStyle(
                                     fontSize: 16.0, fontWeight: FontWeight.bold,
                                     color: Theme.of(context).primaryColor
                                 ),
                                 ),
                                 Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,size: 16.0,)
                               ],
                             ),
                             onTap: (){

                             },
                           )
                          ],
                        )
                    )
                  ],
                ),
              ),
              Divider(), //Linha dividindo o conteudo
              DrawerTile(Icons.home, "Ínicio", pageController, 0), //parametros para construir o tile
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, 'Lojas', pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus pedidos", pageController, 3)
            ],
          )
        ],
      ),
    );
  }
}
