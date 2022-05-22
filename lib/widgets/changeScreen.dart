import 'package:flutter/material.dart';

class ChangeScreen extends StatelessWidget {
  // const ChangeScreen({Key? key}) : super(key: key);
  final Function onTap;
  final String name;
  final String whichAccount;
  final Color? color;
  ChangeScreen(
      {required this.name,
      required this.onTap,
      required this.whichAccount,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Text(
          whichAccount,
          style: TextStyle(fontFamily: 'Lato',fontSize: 18),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: () {
              onTap();
            },
            child: Text(
              name,
              style: TextStyle(
                  color: color == null ? Colors.black : color,
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
            )),
      ],
    ));
  }
}
