import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  // const MyTextFormField({Key? key}) : super(key: key);
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? name;
  final Color? color;
  MyTextFormField({this.name, this.validator, this.color, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: name,
          hintStyle: TextStyle(
            color: color != null ? color : Color.fromARGB(104, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
