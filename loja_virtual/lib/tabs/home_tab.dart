import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({ Key? key }) : super(key: key);  

  @override
  Widget build(BuildContext context) {

    //Função anonima cria um degradê na tela
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 211, 118, 130),
          Color.fromARGB(255, 253, 181, 168)

        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
        )
      ),
    );

    //Stack permite sobrepor elementos
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        
        //Barra superior que se move(esconde) conforme da scroll na tela
        CustomScrollView(
          //Só permite utilizar de componentes slivers
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              snap: true,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text("Novidades"),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('home').orderBy('pos').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData)
                  //Adaptando Box em Sliver pra add um circle progress(Loading...) em um Sliver
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                    ,)
                  );
                
                return SliverStaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  staggeredTiles: snapshot.data!.docs.map(
                    (doc){
                      return StaggeredTile.count(doc.get('x'), doc.get('y').toDouble());
                    }
                  ).toList(),
                children: snapshot.data!.docs.map(
                  (doc){
                    return FadeInImage.memoryNetwork(placeholder: kTransparentImage
                    , image: doc.get('image'), fit: BoxFit.cover,);
                  }

                ).toList(),
                );
                },
            )
          ],
        )
      ],
    );
  }
}