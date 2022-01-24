import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  final _titleController = BehaviorSubject<String>();
  final _imageController = BehaviorSubject();
  final _deleteController = BehaviorSubject<bool>();

  Stream<String> get outTitle => _titleController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (title, sink) {
        if (title.isEmpty)
          sink.addError("Title field cannot be empty.");
        else
          sink.add(title);
      }));
  Stream get outImage => _imageController.stream;
  Stream<bool> get outDelete => _deleteController.stream;
   Stream<bool> get outSubmitedValid => Rx.combineLatest2(
        outTitle,
        outImage,
        (a, b) => true,
      );
  DocumentSnapshot? category;
  File? image;
  String? title;

  CategoryBloc(this.category) {
    if (category != null) {
      title = category!.get('title');
      _titleController.add(category!.get('title'));
      _imageController.add(category!.get('image'));
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  void setImage(File file) {
    image = file;
    _imageController.add(file);
  }

  void setTitle(String title) {
    this.title = title;
    _titleController.add(title);
  }

  Future saveData() async{
    if(image == null &&category != null && category?.get('title') == title) return;

    Map<String, String> dataToUpdate = {};

    if(image != null){
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('icons')
          .child(title!)
          .putFile(image!);

      String downloadUrl = await uploadTask.then((s) async {
        return s.ref.getDownloadURL();
      });
       dataToUpdate['image'] = downloadUrl;

    }

    if(category == null || title != category?.get('title')){
      dataToUpdate['title'] = title!;
      // Categoria não existe, criar uma nova
      if(category == null){
        await FirebaseFirestore.instance.collection('produtos').doc(title).set(dataToUpdate);
      }else{
        await category!.reference.update(dataToUpdate);
      }
    }
  }
  void delete(){
    category?.reference.delete();
  }
  @override
  void dispose() {
    _titleController.close();
    _imageController.close();
    _deleteController.close();
    super.dispose();
  }
}
