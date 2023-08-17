import 'package:flutter/material.dart';

import '../theme/theme_color.dart';

Widget lineDecor() {
  return Container(
    decoration: const BoxDecoration(
        color: AppColor.lineDecor,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    height: 12,
    width: 100,
  );
}
