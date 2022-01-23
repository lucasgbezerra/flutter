import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_manager_app/bloc/product_bloc.dart';
import 'package:store_manager_app/widget/images_widget.dart';

class ProductScreen extends StatelessWidget {
  final String categoryId;
  final DocumentSnapshot? product;

  final _formKey = GlobalKey<FormState>();
  final ProductBloc _productBloc;

  ProductScreen({Key? key, required this.categoryId, this.product})
      : _productBloc = ProductBloc(
            categoryId: categoryId,
            product: product as DocumentSnapshot<Map<String, dynamic>>?),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textFormFieldStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'New Product',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Form(
          key: _formKey,
          child: StreamBuilder<Map>(
              stream: _productBloc.outData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  children: [
                    Text(
                      "Images",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    ImagesWidget(
                      context: context,
                      initialValue: snapshot.data!['images'],
                      validator: (images) {},
                      onSaved: (images) {},
                    ),
                    TextFormField(
                      style: _textFormFieldStyle,
                      initialValue: snapshot.data!['title'],
                      decoration: _buildDecoration("Title"),
                      onSaved: (text) {},
                      validator: (text) {},
                    ),
                    TextFormField(
                      style: _textFormFieldStyle,
                      maxLines: 6,
                      initialValue: snapshot.data!['description'],
                      decoration: _buildDecoration("Description"),
                      onSaved: (text) {},
                      validator: (text) {},
                    ),
                    TextFormField(
                      style: _textFormFieldStyle,
                      initialValue: snapshot.data!['price']?.toStringAsFixed(2),
                      decoration: _buildDecoration("Price"),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSaved: (text) {},
                      validator: (text) {},
                    )
                  ],
                );
              })),
    );
  }
}
