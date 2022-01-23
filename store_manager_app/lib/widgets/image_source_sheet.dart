import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  const ImageSourceSheet({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.camera,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                final imagePicker = ImagePicker();
                XFile? image =
                    await imagePicker.pickImage(source: ImageSource.camera);
                _imageSelectedImage(image);
              },
            ),
            IconButton(
              icon: Icon(Icons.collections),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                // Selecionando imagem com o package
                final imagePicker = ImagePicker();
                //TODO : Fix imagePicker erro
                XFile? image =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                _imageSelectedImage(image);

              },
            )
          ],
        );
      },
    );
  }

  // Recortando imagem com o package
  void _imageSelectedImage(XFile? image) async {
    if (image != null) {
      File? croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      );
      onImageSelected(croppedImage!);
    }
  }
}
