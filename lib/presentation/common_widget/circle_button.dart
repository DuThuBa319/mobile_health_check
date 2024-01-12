import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class CircleButton extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? iconData;
  final void Function()? onTap;
  const CircleButton({
    super.key,
    required this.size,
    this.backgroundColor = Colors.blue,
    this.iconColor = Colors.white,
    required this.iconData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child:
            Center(child: Icon(iconData, size: size * 2 / 3, color: iconColor)),
      ),
    );
  }
}
