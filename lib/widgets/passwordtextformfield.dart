import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  // const PasswordTextFormField({Key? key}) : super(key: key);
  final bool obserText;
  final String? Function(String?)? validator;
  final String? name;
  final Function? onTap;
  final Function(String)? onChanged;
  final Color? color;
  final Color? colorIcon;
  PasswordTextFormField(
      {this.name,
      required this.obserText,
      this.validator,
      this.onTap,
      this.color,
      this.onChanged,
      this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        obscureText: obserText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: name,
          hintStyle: TextStyle(
            color: color != null ? color : Color.fromARGB(104, 0, 0, 0),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              onTap!();
            },
            child: Icon(
              obserText ? Icons.visibility : Icons.visibility_off,
              color: colorIcon != null ? color : Color.fromARGB(171, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }
}
