import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  final String? hint;
  const PasswordFieldWidget({
    Key? key,
    this.hint,
  }) : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value!.length < 7) return "A senha deve ter no mínimo 7 dígitos";
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
                icon: _isVisible == true
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: togglePasswordVisibility),
            hintText: widget.hint != null ? widget.hint : "Senha"),
        obscureText: _isVisible);
  }

  void togglePasswordVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
