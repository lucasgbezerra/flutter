import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(this.icon, this.text, this.controller, this.page, { Key? key }) : super(key: key);

  final String text;
  final IconData icon;
  final PageController controller;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell( //Area retrangular que responde ao toque
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container( //Container para definir o tamanho da tile
          height: 60.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32.0,
                // Se o número da controller for igual a pagina cor primaria, senão cinza
                color: controller.page!.round() == page ? Theme.of(context).primaryColor
                : Colors.grey[700]
              ),
              SizedBox(width: 32.0), //Distanciar o icone do texto
              Text(
                text, 
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page!.round() == page ? Theme.of(context).primaryColor
                : Colors.grey[700]
                ),
              )
            ],
          ),),
      ),
    );
  }
}