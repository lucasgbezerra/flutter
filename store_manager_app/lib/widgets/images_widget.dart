import 'package:flutter/material.dart';
import 'package:store_manager_app/widgets/image_source_sheet.dart';

class ImagesWidget extends FormField<List> {
  ImagesWidget(
      {Key? key,
      required BuildContext context,
      required List initialValue,
      autoValidate = AutovalidateMode.disabled,
      required FormFieldSetter<List> onSaved,
      required FormFieldValidator<List> validator})
      : super(
            key: key,
            initialValue: initialValue,
            autovalidateMode: autoValidate,
            onSaved: onSaved,
            validator: validator,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 124,
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.value!.map<Widget>((image) {
                        return Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            child: image is String
                                ? Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                            onLongPress: () {
                              state.value!.remove(image);
                              state.didChange(state.value);
                            },
                          ),
                        );
                      }).toList()
                        ..add(
                          GestureDetector(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ImageSourceSheet(
                                        onImageSelected: (image) {
                                          state.value!.add(image);
                                          state.didChange(state.value);
                                          Navigator.of(context).pop();
                                        },
                                      ));
                            },
                          ),
                        ),
                    ),
                  ),
                  state.hasError
                      ? Text(
                          state.errorText!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        )
                      : Container()
                ],
              );
            });
}
