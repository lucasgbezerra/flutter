import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.type, this.product, {Key? key}) : super(key: key);

  final String type;
  final ProductData product;

  @override
  Widget build(BuildContext context) {
    // Um card clicável, o InkWell tem uma animação de click que o gestureDetector não
    // tem, por isso utiliza ele
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProductScreen(product: product)));
      },
        child: Card(
      child: type == "grid"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  // AspectRatio definido, dessa forma não irá alterar conforme o dispositivo
                  aspectRatio: 0.8,
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text("\$ ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 17,
                          ))
                    ],
                  ),
                ))
              ],
            )
          : Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.network(
                    product.images[0],
                    height: 250,
                  ),
                ),
                Flexible(
                    child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text("\$ ${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 17,
                          ))
                    ],
                  ),
                ))
              ],
            ),
    ));
  }
}
