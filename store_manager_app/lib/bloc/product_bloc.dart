import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  String categoryId;
  DocumentSnapshot<Map<String, dynamic>>? product;

  late Map<String, dynamic> unsavedData;

  ProductBloc({required this.categoryId, this.product}) {
    if (product != null) {
      unsavedData = Map.of(product!.data()!);
      // Para poder alterar as listas
      unsavedData['images'] = List.of(product!.get('images'));
      unsavedData['sizes'] = List.of(product!.get('sizes'));
      _createdController.add(true);
    } else {
      unsavedData = {
        "images": [],
        "sizes": [],
        "title": null,
        "description": null,
        "price": null,
      };
      _createdController.add(false);
    }

    _dataController.add(unsavedData);
  }

  void saveImages(List? images) {
    if (images != null) unsavedData['images'] = images;
  }

  void saveTitle(String? title) {
    if (title != null) unsavedData['title'] = title;
  }

  void saveDescription(String? description) {
    if (description != null) unsavedData['description'] = description;
  }

  void savePrice(String? price) {
    if (price != null) {
      double? doublePrice = double.parse(price);
      unsavedData['price'] = doublePrice;
    }
  }

  void saveSizes(List? sizes) {
    if (sizes != null) unsavedData['sizes'] = sizes;
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);
    try {
      if (product != null) {
        await _uploadImages(product!.id);
        await product!.reference.update(unsavedData);
      } else {
        // Criar um doc do produto sem as imagens para obter o doc_id necessário pra add imagens
        Map<String, dynamic> unsavedDataNoImage = Map.from(unsavedData);
        unsavedDataNoImage['images'] = [];
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection('produtos')
            .doc(categoryId)
            .collection('items')
            .add(unsavedDataNoImage);
        await _uploadImages(docRef.id);
        await docRef.update(unsavedData);
      }
      _createdController.add(true);
      _loadingController.add(false);
      return true;
    } catch (e) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String productId) async {
    for (int i = 0; i < unsavedData['images'].length; i++) {
      if (unsavedData['images'][i] is String) continue;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(productId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData['images'][i]);

      String downloadUrl = await uploadTask.then((s) async {
        return s.ref.getDownloadURL();
      });
      unsavedData['images'][i] = downloadUrl;
    }
  }

  void deleteProduct() {
    product!.reference.delete();
  }
  @override
  void dispose() {
    _loadingController.close();
    _dataController.close();
    _createdController.close();
    super.dispose();
  }
}
