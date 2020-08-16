import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {

  Widget _buildBodyBackground() => Container( //Criando degradê por tras das imagens
    decoration: BoxDecoration(
      gradient: LinearGradient(//degrade linear
        colors: [
          Color(0xff00C9FF),//cores
          Color(0xff92FE9D),
        ],
        begin: Alignment.topLeft,//inicio e fim
        end: Alignment.bottomRight
      )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack( //Colocar algo sobre outra coisa
                  //no caso sobre o degrade criado
      children: [
        _buildBodyBackground(),
        CustomScrollView( //Scrool view customizado para a app bar
          slivers: [
            SliverAppBar(
              floating: true, //flutuando
              snap: true, // quando puxar pra baixo some, pra cima aparece
              elevation: 0.0, //elevação da barra
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"), // imutavel e predefinida
                centerTitle: true,
              ),
            ),
          FutureBuilder<QuerySnapshot>(//tipo Querysnapshot
              future: Firestore.instance.collection('home').orderBy('pos').getDocuments(), //Obtendo as imagens, e carregando
              builder: (context, snapshot){
                if(!snapshot.hasData){//caso não tenha nenhum dado
                  return SliverToBoxAdapter(//Só aceita widgets do tipo sliver logo farei uma adaptação
                    child: Container(
                      height: 250.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                        ,),
                    ),
                  );
                }else{
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2, //Qtd de blocos da grade, na horizontal
                    crossAxisSpacing: 1.0, //Espaçamento horizontal
                    mainAxisSpacing: 1.0, //Espaçamento vertical
                    staggeredTiles: snapshot.data.documents.map(//lista de dimensões das grades, pegar o x e y e transformar
                        (doc){
                          return StaggeredTile.count(doc.data['x'], doc.data['y']);
                        }
                    ).toList(),
                    children: snapshot.data.documents.map(
                        (doc){
                          return FadeInImage.memoryNetwork(placeholder: kTransparentImage,
                              image: doc.data['image'],
                            fit: BoxFit.cover,
                          );
                        }
                    ).toList()
                    ,
                  );
                }
              }
          )
          ],
        )
      ],
    );
  }
}
