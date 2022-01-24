import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_manager_app/bloc/product_bloc.dart';
import 'package:store_manager_app/validators/product_validator.dart';
import 'package:store_manager_app/widgets/images_widget.dart';
import 'package:store_manager_app/widgets/product_sizes_widget.dart';

class ProductScreen extends StatefulWidget with ProductValidator {
  final String categoryId;
  final DocumentSnapshot? product;

  ProductScreen({Key? key, required this.categoryId, this.product})
      : super(key: key);

  @override
  State<ProductScreen> createState() =>
      _ProductScreenState(categoryId, product);
}

class _ProductScreenState extends State<ProductScreen> with ProductValidator {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProductBloc _productBloc;

  _ProductScreenState(String categoryId, DocumentSnapshot? product)
      : _productBloc = ProductBloc(
            categoryId: categoryId,
            product: product as DocumentSnapshot<Map<String, dynamic>>?);

  @override
  Widget build(BuildContext context) {
    const _textFormFieldStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(
                snapshot.data! ? 'Edit Product' : 'New Product',
                style: const TextStyle(color: Colors.white),
              );
            }),
        // centerTitle: true,
        actions: [
          StreamBuilder<bool>(
              stream: _productBloc.outCreated,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data!) {
                  return StreamBuilder<bool>(
                      stream: _productBloc.outLoading,
                      initialData: false,
                      builder: (context, snapshot) {
                        return IconButton(
                          onPressed: snapshot.data!
                              ? null
                              : () {
                                  _productBloc.deleteProduct();
                                  Navigator.of(context).pop();
                                },
                          icon: const Icon(Icons.delete),
                        );
                      });
                } else {
                  return Container();
                }
              }),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                  onPressed: snapshot.data! ? null : saveProduct,
                  icon: const Icon(Icons.save),
                );
              }),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: StreamBuilder<Map>(
                stream: _productBloc.outData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return ListView(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    children: [
                      const Text(
                        "Images",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      ImagesWidget(
                        context: context,
                        initialValue: snapshot.data!['images'],
                        onSaved: _productBloc.saveImages,
                        validator: validateImages,
                      ),
                      TextFormField(
                        style: _textFormFieldStyle,
                        initialValue: snapshot.data!['title'],
                        decoration: _buildDecoration("Title"),
                        onSaved: _productBloc.saveTitle,
                        validator: validateTitle,
                      ),
                      TextFormField(
                        style: _textFormFieldStyle,
                        maxLines: 6,
                        initialValue: snapshot.data!['description'],
                        decoration: _buildDecoration("Description"),
                        onSaved: _productBloc.saveDescription,
                        validator: validateDescription,
                      ),
                      TextFormField(
                        style: _textFormFieldStyle,
                        initialValue:
                            snapshot.data!['price']?.toStringAsFixed(2),
                        decoration: _buildDecoration("Price"),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onSaved: _productBloc.savePrice,
                        validator: validatePrice,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Sizes",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      ProductSizesWidget(
                          context: context,
                          initialValue: snapshot.data!['sizes'],
                          onSaved: _productBloc.saveSizes,
                          validator: validateSizes)
                    ],
                  );
                }),
          ),
          StreamBuilder<bool>(
              stream: _productBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data!,
                  child: Container(
                    color: snapshot.data! ? Colors.black54 : Colors.transparent,
                  ),
                );
              })
        ],
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text(
            "Saving product...",
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(minutes: 1),
        ),
      );

      bool success = await _productBloc.saveProduct();

      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            success
                ? "Product has been saved sucessfully."
                : "Failed to save product.",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
