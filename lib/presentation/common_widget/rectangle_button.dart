import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  final double height;
  final double? width;
  final Color? buttonColor;
  final String title;
  final Color? textColor;
  final double? sizeText;
  final bool? editSizeText;
  final void Function()? onTap;
  const RectangleButton(
      {super.key,
      this.editSizeText,
      this.sizeText,
      this.width,
      this.buttonColor = Colors.blue,
      required this.height,
      this.onTap,
      this.textColor = Colors.white,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: height,
        width: width ?? MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.only(
            top: height / 4, bottom: height / 4, right: 10, left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: buttonColor),
        child: Center(
          child: Text(
            title,
            style: editSizeText == true
                ? TextStyle(
                    fontSize: sizeText,
                    fontWeight: FontWeight.bold,
                    color: textColor)
                : TextStyle(
                    fontSize: height / 2.5,
                    fontWeight: FontWeight.bold,
                    color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
