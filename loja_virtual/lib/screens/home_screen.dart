import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController(); //controller pages

  @override
  Widget build(BuildContext context) {
    return PageView( //Mudar a pagina, por arrasto ou controller como é o caso

      physics: NeverScrollableScrollPhysics(),//impede mudança de paginas por arrasto
      controller: _pageController,
      children: [
       Scaffold( //Para utilizar o drawer é preciso ter um scaffold
         drawer: CustomDrawer(_pageController),
         body: HomeTab(),//paginainicial
       ),
      ],
    );
  }
}
