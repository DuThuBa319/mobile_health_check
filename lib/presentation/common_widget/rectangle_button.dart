import 'package:flutter/material.dart';
import 'package:mobile_health_check/utils/size_config.dart';

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
    SizeConfig.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: buttonColor),
        child: Center(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
