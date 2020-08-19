import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget { //Statefull pois a tela sofrera mudanças
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  //para não ficar usando widget.produtc, cria-se um contrutor no state
  final ProductData product;
  _ProductScreenState(this.product);


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Color(0xff00C9FF),
    title: Text(product.title),
    centerTitle: true,),
      backgroundColor: Colors.white,);
  }
}
