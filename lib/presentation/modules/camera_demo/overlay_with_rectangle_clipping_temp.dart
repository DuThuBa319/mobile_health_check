import 'package:flutter/material.dart';
import 'package:mobile_health_check/common/singletons.dart';

class OverlayRectangleForTemperature extends StatelessWidget {
  const OverlayRectangleForTemperature({super.key});

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
      size.width * 0.202,
      size.height * 0.24,
      size.width * 0.6,
      size.height * 0.122,
      0
    ];
    //? sizeFrame[0]: left
    //? sizeFrame[1]: top
    //? sizeFrame[2]: width
    //? sizeFrame[3]: height
    //? sizeFrame[4]: radius
    //? initial => T1
    switch (userDataData.localDataManager.preferencesHelper
        .getData('TempEquipModel')) {
      case 0: //?T1 => DONE
        sizeFrame[0] = size.width * 0.202;
        sizeFrame[1] = size.height * 0.24;
        sizeFrame[2] = size.width * 0.6;
        sizeFrame[3] = size.height * 0.122;
        sizeFrame[4] = 0;
        break;
      case 1: //? T2
        sizeFrame[0] = size.width * 0.25;
        sizeFrame[1] = size.height * 0.15;
        sizeFrame[2] = size.width * 0.55;
        sizeFrame[3] = size.height * 0.28;
        sizeFrame[4] = 0;
        break;
      case 2: //? T3
        sizeFrame[0] = size.width * 0.25;
        sizeFrame[1] = size.height * 0.15;
        sizeFrame[2] = size.width * 0.55;
        sizeFrame[3] = size.height * 0.28;
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
