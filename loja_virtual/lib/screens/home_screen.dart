import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/categories_tap.dart';
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
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff00C9FF),
            title: Text('Products', style: TextStyle(fontSize: 20.0,),),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoriesTap(),
        )
      ],
    );
  }
}
