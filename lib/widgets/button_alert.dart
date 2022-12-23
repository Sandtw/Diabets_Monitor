import 'package:flutter/material.dart';
import 'package:diabets_monitor/utils/font.dart';

class ButtonAlert extends StatelessWidget {
  void Function()? onTap;
  Color color;
  String text;

  ButtonAlert({
    required this.text,
    required this.onTap,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: color),
          child: Center(
              child: Text(text,
                  style: APTextStyle
                      .titleInputText
                      .copyWith(color: Colors.white)))),
    );
  }
}