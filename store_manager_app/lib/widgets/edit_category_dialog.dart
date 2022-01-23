import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_manager_app/bloc/category_bloc.dart';
import 'package:store_manager_app/widgets/image_source_sheet.dart';

class EditCategoryDialog extends StatefulWidget {
  final DocumentSnapshot? category;

  EditCategoryDialog({this.category, Key? key}) : super(key: key);

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState(category);
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final CategoryBloc _categoryBloc;
  final TextEditingController _textController;

  _EditCategoryDialogState(DocumentSnapshot? category)
      : _categoryBloc = CategoryBloc(category),
        _textController = TextEditingController(
            text: category != null ? category.get('title') : "");
  @override
  build(BuildContext context) {
    return Dialog(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        ImageSourceSheet(onImageSelected: (image) {
                      Navigator.of(context).pop();
                      _categoryBloc.setImage(image);
                    }),
                  );
                },
                child: StreamBuilder(
                    stream: _categoryBloc.outImage,
                    builder: (context, snapshot) {
                      if (snapshot.data != null)
                        return CircleAvatar(
                          child: snapshot.data is String
                              ? Image.network(
                                  "${snapshot.data!}",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  snapshot.data! as File,
                                  fit: BoxFit.cover,
                                ),
                          backgroundColor: Colors.transparent,
                        );
                      else
                        return Icon(Icons.image);
                    }),
              ),
              title: StreamBuilder<String>(
                  stream: _categoryBloc.outTitle,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString() : null,
                      ),
                      onChanged: _categoryBloc.setTitle,
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<bool>(
                    stream: _categoryBloc.outDelete,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Container();
                      return TextButton(
                        onPressed: snapshot.data! ? () {} : null,
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: snapshot.data! ? Colors.red : Colors.grey),
                        ),
                      );
                    }),
                StreamBuilder<bool>(
                    stream: _categoryBloc.outSubmitedValid,
                    builder: (context, snapshot) {
                      return TextButton(
                        onPressed: snapshot.hasData ? () {} : null,
                        child: Text("Save"),
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
