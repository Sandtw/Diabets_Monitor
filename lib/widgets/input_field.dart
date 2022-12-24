import 'package:flutter/material.dart';
import 'package:diabets_monitor/utils/font.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String type;
  Map<String, TextInputType> keyboardType = {
    'email': TextInputType.emailAddress,
    'text' : TextInputType.text,
    'phone': TextInputType.phone
  };

   InputField({
    Key? key, required this.hint, required this.prefixIcon, required this.controller, required this.type,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: keyboardType[type],
        controller: controller,
        obscureText: type == 'password' ? true:false,
        style: APTextStyle.titleInputText,
        decoration:  InputDecoration(
          border:  const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.white),
          ),
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
        ),
        validator: (value){
          switch(type){
            case 'email':
              if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                return "Ingresar correctamente el ${hint.toLowerCase()}";
              }
              break;
            case 'text':
              if(value!.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)){
                return "Ingresar correctamente el ${hint.toLowerCase()}";
              }else{
                return null;
              }
            case 'phone':
              if(value!.isEmpty || !RegExp(r'^\+[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)){
                return "Ingresar correctamente el ${hint.toLowerCase()}";
              }else{
                return null;
              }

            }
          }
      ),
    );
  }
}