import 'package:flutter/material.dart';
import 'package:mobile_health_check/common/singletons.dart';

class OverlayRectangleForBloodSugar extends StatelessWidget {
  const OverlayRectangleForBloodSugar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: _getCustomPaintOverlay(context));
  }

  //CustomPainter that helps us in doing this
  CustomPaint _getCustomPaintOverlay(BuildContext context) {
    return CustomPaint(
        size: MediaQuery.of(context).size, painter: RectanglePainter());
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    List<double> sizeFrame = [
      size.width * 0.105,
      size.height * 0.185,
      size.width * 0.8,
      size.height * 0.24,
      0,
    ];
    //? sizeFrame[0]: left
    //? sizeFrame[1]: top
    //? sizeFrame[2]: width
    //? sizeFrame[3]: height
    //? sizeFrame[4]: radius
    //? initial => BS1
    switch (userDataData.localDataManager.preferencesHelper
        .getData('BloodSugarEquipModel')) {
      case 0: //?BS1 => Done
        sizeFrame[0] = size.width * 0.1;
        sizeFrame[1] = size.height * 0.2;
        sizeFrame[2] = size.width * 0.8;
        sizeFrame[3] = size.height * 0.143;
        sizeFrame[4] = 0;
        break;
      case 1: //?BS2 => Done
        sizeFrame[0] = size.width * 0.05;
        sizeFrame[1] = size.height * 0.185;
        sizeFrame[2] = size.width * 0.9;
        sizeFrame[3] = size.height * 0.165;
        sizeFrame[4] = 0;
        break;
    }
    canvas.drawPath(
        Path.combine(
          PathOperation.difference, //simple difference of following operations
          //bellow draws a rectangle of full screen (parent) size
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          //bellow clips out the circular rectangle with center as offset and dimensions you need to set
          Path()
            ..addRRect(RRect.fromRectAndRadius(
                Rect.fromLTWH(
                    sizeFrame[0], sizeFrame[1], sizeFrame[2], sizeFrame[3]),
                Radius.circular(sizeFrame[4])))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
