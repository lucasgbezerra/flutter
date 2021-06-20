import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(this.snapshot, { Key? key }) : super(key: key);

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    //Screen com uma tab bar definindo duas organizações
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.get('title')), 
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),)],),  
      ),
      body: TabBarView(children: [
        Container(color: Colors.red,),
        Container(color: Colors.blue,)
      ],),
    ),
    );
  }
}