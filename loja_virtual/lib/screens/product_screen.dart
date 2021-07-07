import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
              aspectRatio: 0.9,
              //Carrossel de imagens, product.images é um array de URLs, map para passar
              //para imagens
              child: CarouselSlider(
                items: product.images.map((url) {
                  return Image.network(url);
                }).toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  height: 250,
                  aspectRatio: 1
                ),
              ))
        ],
      ),
    );
  }
}
