import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // const MyButton({Key? key, this.name, this.onPressed}) : super(key: key);

  final Function onPressed;
  final String? name;
  final Color? color;
  final double? width;
  MyButton({this.name, required this.onPressed, this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width == null ? double.infinity : width,
      child: RaisedButton(
        child: Text(
          name.toString(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          onPressed();
        },
        color: color == null ? Colors.lightBlue : color,
      ),
    );
  }
}
