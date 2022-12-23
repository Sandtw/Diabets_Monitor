import 'package:flutter/material.dart';
import 'package:diabets_monitor/utils/font.dart';

class ButtonAlertOnlyBorder extends StatelessWidget {
  void Function()? onTap;
  String text;
  Color color;
  ButtonAlertOnlyBorder({
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
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: Center(
              child: Text(text,
                  style: APTextStyle
                      .titleInputText
                      .copyWith(color: color)))),
    );
  }
}