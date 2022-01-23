import 'package:flutter/material.dart';
import 'package:store_manager_app/widgets/add_size_dialog.dart';

class ProductSizesWidget extends FormField<List> {
  ProductSizesWidget({
    required BuildContext context,
    required List initialValue,
    required FormFieldSetter<List> onSaved,
    required FormFieldValidator<List> validator,
  }) : super(
            initialValue: initialValue,
            validator: validator,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 34,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8.0,
                        crossAxisCount: 1,
                        childAspectRatio: 0.5,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(top: 4),
                      children: state.value!.map((size) {
                        return GestureDetector(
                          onLongPress: () {
                            // Remover tamanho da lista de tamanhos
                            state.didChange(state.value!..remove(size));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList()
                        ..add(GestureDetector(
                          onTap: () async {
                            String? size = await showDialog(
                                context: context,
                                builder: (context) => AddSizeDialog());
                            if (size != null && size.isNotEmpty) {
                              state.value!.add(size);
                              state.didChange(state.value);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: state.hasError
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    ),
                  ),
                  state.hasError
                      ? Container(
                        padding: EdgeInsets.only(top:2),
                        child: Text(
                            state.errorText!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                      )
                      : Container()
                ],
              );
            });
}
