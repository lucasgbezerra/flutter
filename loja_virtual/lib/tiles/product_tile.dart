import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () { //Ao clicar ir para tela do produto
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductScreen(product)));
        },
        child: Card(
            //Criando card do produto
            child: type == 'grid'
                ? Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start, //Imagem começando da ponta
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch, //imagem esticada
                    children: [
                      AspectRatio(
                        //Para estabelecer um tamanho igual independente do dispositivo
                        aspectRatio: 0.8,
                        child: Image.network(
                          product.images[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'R\$ ${product.price.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Row(
              children: [
                Flexible( //Divide o espaço da linha em 2 flexibles como 1 e 1 em tamanhos iguais
                    flex: 1,
                    child: Image.network(product.images[0],fit: BoxFit.cover,)
                ),
                Flexible(flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    )
                ),

              ],
            )
        )
    );
  }
}
