import 'package:flutter/material.dart';
import 'package:diabets_monitor/utils/font.dart';

class InputField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;

  const InputField({
    Key? key, required this.hint, required this.prefixIcon, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: hint == 'Contraseña' ? true:false,
        style: APTextStyle.titleInputText,
        decoration:  InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
          focusColor: const Color.fromARGB(255, 237, 238, 160),
        ),
    ),
    );
  }
}