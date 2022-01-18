import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscuretext;
  const InputField(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.obscuretext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.black,
          width: 0.5,
        )),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        obscureText: obscuretext,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
            contentPadding:
                const EdgeInsets.only(bottom: 30, right: 30, top: 30, left: 5),
            border: InputBorder.none),
      ),
    );
  }
}