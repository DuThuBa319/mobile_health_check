import 'package:flutter/material.dart';

import '../theme/theme_color.dart';

Widget lineDecor({double spaceTop = 0, double spaceBottom = 0}) {
  return Container(
    margin: EdgeInsets.only(top: spaceTop, bottom: spaceBottom),
    decoration: const BoxDecoration(
        color: AppColor.lineDecor,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    height: 12,
    width: 100,
  );
}
