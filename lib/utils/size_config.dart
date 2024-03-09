import 'dart:math';

import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();

  ///Logical pixel của chiều ngang điện thoại đang chạy ứng dụng
  static double screenWidth = 0;

  ///Logical pixel của chiều dọc điện thoại đang chạy ứng dụng
  static double screenHeight = 0;
  //Sample là Google Pixel 3, các điện thoại khác thì phải debug để xem lại Logical Pixel của nó.

  ///Logical pixel của chiều ngang điện thoại tham chiếu Google Pixel 3
  static double screenWidthSample = 392.727272727272727272;

  ///Logical pixel của chiều dọc điện thoại tham chiếu Google Pixel 3
  static double screenHeightSample = 737.45454545454545454;

  ///Tỉ lệ chiều ngang của điện thoại chạy ứng dụng/điện thoại tham chiếu Pixel 3
  static double ratioWidth = 0;
  static double ratioScreen = 1;

  ///Tỉ lệ chiều dọc của điện thoại chạy ứng dụng/điện thoại tham chiếu Pixel 3
  static double ratioHeight = 0;

  static double ratioFont = 0;
  static double ratioRadius = 0;
  static double screenDiagonal = 0;
  static Size size = Size.zero;

  ///Hàm chạy để khởi tạo các giá trị tỉ lệ, dùng trong trang đầu tiên của ứng dụng
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    size = MediaQuery.of(context).size;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    ratioWidth = screenWidth / screenWidthSample;
    ratioHeight = screenHeight / screenHeightSample;
    ratioFont = min(ratioWidth, ratioHeight);
    ratioRadius = ratioFont;
    ratioScreen = screenWidth / screenHeight;
    screenDiagonal =
        sqrt(screenWidth * screenWidth + screenHeight * screenHeight);
  }
}
