import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  String? size;

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
            child: GFCarousel(
              items: product.images.map((url) {
                return Image.network(url);
              }).toList(),
              autoPlay: false,
              height: 400,
              pagination: true,
              passiveIndicator: Colors.grey,
              activeIndicator: primaryColor,
              pagerSize: 6.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: s == size ? primaryColor : Colors.grey,
                                width: 2.0),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "Adicionar ao carrinho",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    onPressed: size != null ? () {} : null,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição: ",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}