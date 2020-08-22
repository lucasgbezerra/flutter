import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  String size;

  _ProductScreenState(this.product);


  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(appBar: AppBar(backgroundColor: Color(0xff00C9FF),
    title: Text(product.title),
    centerTitle: true,),
      body: ListView( //Usei o list View pois permite roll e pode ser necessario
        children: [
          AspectRatio( //Para definir um tamanho fixo pra imagem
              aspectRatio: 0.9,
            child:  Carousel( //plugin para imagens
              images:
                product.images.map((url){
                  return NetworkImage(url);
                }).toList(),
              dotBgColor: Colors.transparent,
              dotSpacing: 15.0,
              dotColor: primaryColor,
              dotSize: 4.0,
              autoplay: false,
            ),
          ),
          Padding(padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, //esticar no maximo
              children: [
                Text(product.title, style: TextStyle(fontSize: 16.0,
                    fontWeight: FontWeight.w600),maxLines: 3,),
                Text('R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.0, color: primaryColor,
                      fontWeight: FontWeight.bold),),
              SizedBox(height: 16.0,), //espaçamento
                Text('Tamanho', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8.0, // espaçamento horizontal
                        crossAxisCount: 1, //num de linhas
                        childAspectRatio: 0.5, //A largura 2x a altura
                  ),
                    children: product.sizes.map((s){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            size =s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              color: s == size ? primaryColor : Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList()
                  ),
                ),
              SizedBox(height: 16.0,),
                SizedBox( //Para especificar o tamanho do botão
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != null ? (){} : null, //desativa o botão caso size seja null
                    child: Text('Adcionar ao carrinho',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                Text(product.description, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),),
              ],
            ),
          )
        ],
      ),);
  }
}
