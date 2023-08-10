import 'package:flutter/material.dart';
import 'theme_color.dart';

class AppTextTheme {
  static const fontSize0 = 30.0;
  static const fontSize1 = 24.0;
  static const fontSize2 = 18.0;
  static const fontSize3 = 16.0;
  static const fontSize4 = 14.0;
  static const fontSize5 = 12.0;
  static const fontSize6 = 10.0;
  static const fontSize7 = 8.0;
  static TextStyle textLinkStyle = const TextStyle(
    decoration: TextDecoration.underline,
    color: AppColor.primaryColorLight,
    fontSize: 14,
  );
  static TextStyle body0 = const TextStyle(
    color: Colors.black,
    fontSize: fontSize0,
  );

  static TextStyle body1 = const TextStyle(
    color: Colors.black,
    fontSize: fontSize1,
  );

  static TextStyle body2 = const TextStyle(
    color: Colors.black,
    fontSize: fontSize2,
  );

  static TextStyle body3 = const TextStyle(
    color: Colors.black,
    fontSize: fontSize3,
  );

  static TextStyle body4 = const TextStyle(
    color: Colors.black,
    fontSize: fontSize4,
  );

  static TextStyle body5 = const TextStyle(
    color: Colors.black,
    fontSize: fontSize5,
  );

  static TextStyle title0 = const TextStyle(
    color: AppColor.gray767676,
    fontSize: fontSize0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle title1 = const TextStyle(
    color: AppColor.gray767676,
    fontSize: fontSize1,
    fontWeight: FontWeight.bold,
  );

  static TextStyle title2 = const TextStyle(
    color: AppColor.gray767676,
    fontSize: fontSize2,
    fontWeight: FontWeight.bold,
  );

  static TextStyle title3 = const TextStyle(
    color: AppColor.gray767676,
    fontSize: fontSize3,
    fontWeight: FontWeight.bold,
  );

  static TextStyle title4 = const TextStyle(
    color: AppColor.gray767676,
    fontSize: fontSize4,
    fontWeight: FontWeight.bold,
  );

  static TextStyle title5 = const TextStyle(
    color: AppColor.gray767676,
    fontSize: fontSize5,
    fontWeight: FontWeight.bold,
  );

  static TextTheme getDefaultTextTheme() => const TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryText,
        ),
        titleLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColor.subText,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColor.subText,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.subText,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryText,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
  static TextTheme getDefaultTextThemeDark() => const TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryDarkText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryDarkText,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColor.primaryDarkText,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColor.subDarkText,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.subDarkText,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryDarkText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColor.primaryDarkText,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryDarkText,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryDarkText,
        ),
      );
}
