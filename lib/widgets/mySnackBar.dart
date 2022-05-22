import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  // const MySnackBar({ Key? key }) : super(key: key);
  final String message;
  final String? fontFamily;
  final Color? colorFont;
  final Color? colorBackground;
  final double? height;
  final double? fontSize;
  final TextAlign? textAlign;
  final Duration? duration;

  const MySnackBar(
      {required this.message,
      this.fontFamily,
      this.colorFont,
      this.colorBackground,
      this.fontSize,
      this.textAlign,
      this.duration,
      this.height});
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Container(
        height: height == null ? 50 : height,
        child: Text(
          message,
          style: TextStyle(
            color: colorFont == null ? Colors.white : colorFont,
            fontSize: fontSize == null ? 20 : fontSize,
            fontFamily: fontFamily == null ? 'Lato' : fontFamily,
          ),
          textAlign: textAlign == null ? TextAlign.start : textAlign,
        ),
      ),
      duration: duration == null ? Duration(seconds: 5) : duration!,
      backgroundColor:
          colorBackground == null ? Colors.black54 : colorBackground,
    );
  }
}
