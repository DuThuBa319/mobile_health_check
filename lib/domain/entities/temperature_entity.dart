import 'package:flutter/material.dart';

import '../../data/models/temperature_model.dart';

class TemperatureEntity {
  double? temperature;
  DateTime? updatedDate;
  String? imageLink;

  TemperatureEntity({this.temperature, this.updatedDate, this.imageLink});
  Color? get statusColor {
    if (temperature != null) {
      if (temperature! < 35.9) {
        //|| dia! <= 60
        return Colors.blue;
      } else if (36 <= temperature! && temperature! <= 36.9) {
        //|| dia! <= 80
        return const Color.fromARGB(255, 64, 247, 70);
      } else if (temperature! >= 37 && temperature! <= 38) {
        //|| dia! >= 80 && dia! <= 89
        return Colors.orange;
      } else if (temperature! >= 38.1) {
        //|| dia! >= 90 && dia! <= 99
        return Colors.red;
      }
    }

    return Colors.grey;
  }

  String get comment {
    if (temperature != null) {
      if (temperature! < 35.9) {
        //|| dia! <= 60
        return 'Thân nhiệt thấp';
      } else if (36 <= temperature! && temperature! <= 36.9) {
        //|| dia! >= 80 && dia! <= 89
        return ' Thân nhiệt bình thường'; //  Thân nhiệt cao
      } else if (temperature! >= 37 && temperature! <= 38) {
        //|| dia! >= 90 && dia! <= 99
        return 'Thân nhiệt cao';
      } else if (temperature! >= 38.1) {
        //|| dia! >= 100 && dia! <= 109
        return 'Thân nhiệt rất cao';
      }
    }

    return '--';
  }

  TemperatureModel getTemperatureModel() {
    return TemperatureModel(
        imageLink: imageLink,
        temperature: temperature,
        updatedDate: updatedDate);
  }
}
