import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  final _controller = TextEditingController();
  AddSizeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
              child: Text(
                "Add",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
