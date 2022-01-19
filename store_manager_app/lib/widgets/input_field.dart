import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscuretext;
  final Stream<String?> stream;
  final Function(String) onChanged;
  const InputField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.obscuretext,
    required this.stream,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: stream,
        builder: (context, snapshot) {
          return TextFormField(
            style: const TextStyle(color: Colors.white),
            obscureText: obscuretext,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
              contentPadding: const EdgeInsets.only(
                  bottom: 30, right: 30, top: 30, left: 5),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
            ),
            onChanged: onChanged,
          );
        });
  }
}
