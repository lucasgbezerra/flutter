import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  //Construtor
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);
  //Cada tile terá um icone, texto e o número de pagina ao qual corresponde
  // o controller é passado para alterar entre paginas clicando InkWeel(), no tile

  @override
  Widget build(BuildContext context) {
    return Material( //Material permite um efeito visual de click
      color: Colors.transparent,
      child: InkWell( //Ink reactions
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container( //Container que  armazenara cada drawertile
          height: 60.0,
          child: Row(
            children: [
              Icon(icon, size: 25.0,
                color: controller.page.round() == page ? Theme.of(context).primaryColor :
                Colors.grey.shade700,),
              SizedBox(width: 32.0,),
              Text(text, style: TextStyle(fontSize: 20.0,
                color: controller.page.round() == page ? Theme.of(context).primaryColor :
              Colors.grey.shade700,),)
            ],
          ),
        ),
      ),
    );
  }
}
