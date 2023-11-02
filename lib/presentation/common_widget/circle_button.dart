import 'package:flutter/material.dart';

import '../../function.dart';

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
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(iconData, size: size * 2 / 3, color: iconColor),
          onPressed: onTap),
    );
  }
}
