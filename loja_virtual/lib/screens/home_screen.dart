import 'package:flutter/material.dart';
import 'package:loja_virtual/taps/home_tab.dart';
import 'package:loja_virtual/taps/product_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget{
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
  
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      //jumpToPage() ou animateToPage para mudar a page
      children: <Widget>[
        //Navigate Drawer dentro de um Scafold
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Products"),
            centerTitle: true,
            ),
          body: ProductTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}