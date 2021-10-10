import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String txt;
  final double size;
  final VoidCallback onPressed;

  ProductivityButton(
      {required this.color,
      required this.txt,
      required this.size,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        txt,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
      color: color,
      minWidth: size,
    );
  }
}

typedef CallbackSettings = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String txt;
  final double size;
  final int value;
  final String setting;
  final CallbackSettings callback;

  const SettingButton(
      {required this.color,
      required this.txt,
      required this.value,
      required this.size,
      required this.setting,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        txt,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => callback(setting, value),
      color: color,
      minWidth: size,
      //shape: CircleBorder(),
    );
  }
}
