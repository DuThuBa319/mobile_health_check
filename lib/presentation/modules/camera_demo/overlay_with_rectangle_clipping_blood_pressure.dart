import 'package:flutter/material.dart';
import 'package:mobile_health_check/common/singletons.dart';

class OverlayRectangleForBloodPressure extends StatelessWidget {
  const OverlayRectangleForBloodPressure({super.key});

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
    List<double> sizeFrame = [
      size.width * 0.25,
      size.height * 0.15,
      size.width * 0.55,
      size.height * 0.28,
      0
    ];
    //? sizeFrame[0]: left
    //? sizeFrame[1]: top
    //? sizeFrame[2]: width
    //? sizeFrame[3]: height
    //? sizeFrame[4]: radius
    //? initial => BP1
    switch (userDataData.localDataManager.preferencesHelper
        .getData('BloodPressureEquipModel')) {
      case 0: //?BP1 => Done
        sizeFrame[0] = size.width * 0.25;
        sizeFrame[1] = size.height * 0.15;
        sizeFrame[2] = size.width * 0.55;
        sizeFrame[3] = size.height * 0.28;
        sizeFrame[4] = 0;
        break;
      case 1: //?BP2 =>  Done
        sizeFrame[0] = size.width * 0.2;
        sizeFrame[1] = size.height * 0.16;
        sizeFrame[2] = size.width * 0.6;
        sizeFrame[3] = size.height * 0.31;
        sizeFrame[4] = 20;
        break;
      case 2: //?BP3 => Done
        sizeFrame[0] = size.width * 0.155;
        sizeFrame[1] = size.height * 0.16;
        sizeFrame[2] = size.width * 0.75;
        sizeFrame[3] = size.height * 0.3;
        sizeFrame[4] = size.width * 0.1;
        break;
      case 3: //?BP4 => Done
        sizeFrame[0] = size.width * 0.2;
        sizeFrame[1] = size.height * 0.15;
        sizeFrame[2] = size.width * 0.65;
        sizeFrame[3] = size.height * 0.285;
        sizeFrame[4] = 47;
        break;
    }

    final paint = Paint()..color = Colors.black54;
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
