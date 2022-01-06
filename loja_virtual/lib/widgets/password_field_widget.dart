import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  final String? hint;
  TextEditingController controller;
  final String? Function(String?)? validator;

  PasswordFieldWidget(
      {Key? key,
      this.hint,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
                icon: _isVisible == true
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: togglePasswordVisibility),
            hintText: widget.hint != null ? widget.hint : "Password"),
        obscureText: _isVisible);
  }

  void togglePasswordVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
