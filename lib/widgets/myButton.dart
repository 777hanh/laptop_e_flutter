import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // const MyButton({Key? key, this.name, this.onPressed}) : super(key: key);

  final Function onPressed;
  final String? name;
  final Color? color;
  MyButton({this.name, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
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
