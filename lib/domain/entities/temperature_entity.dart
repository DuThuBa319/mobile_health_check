import 'package:flutter/material.dart';

import '../../classes/language.dart';
import '../../data/models/temperature_model/temperature_model.dart';

class TemperatureEntity {
  double? temperature;
  DateTime? updatedDate;
  String? imageLink;

  TemperatureEntity({this.temperature, this.updatedDate, this.imageLink});
  TemperatureEntity copywith({
    double? temperature,
    String? imageLink,
    DateTime? updatedDate,
  }) {
    return TemperatureEntity(
        temperature: temperature ?? this.temperature,
        imageLink: imageLink ?? this.imageLink,
        updatedDate: updatedDate ?? this.updatedDate);
  }

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
        return Colors.red;
      } else if (temperature! >= 38.1) {
        //|| dia! >= 90 && dia! <= 99
        return Colors.red;
      }
    }

    return Colors.grey;
  }

  String statusComment(BuildContext context) {
    if (temperature != null) {
      if (temperature! < 35.9) {
        //|| dia! <= 60
        return translation(context).hypothermia;
      } else if (36 <= temperature! && temperature! <= 36.9) {
        //|| dia! >= 80 && dia! <= 89
        return translation(context).normalBT; //  Thân nhiệt cao
      } else if (temperature! >= 37 && temperature! <= 38) {
        //|| dia! >= 90 && dia! <= 99
        return translation(context).hyperthermia;
      } else if (temperature! >= 38.1) {
        //|| dia! >= 100 && dia! <= 109
        return translation(context).veryhightbodytemperature;
      }
    }

    return '--';
  }

  TemperatureModel getTemperatureModel() {
    return TemperatureModel(
        imageLinkTemperature: imageLink,
        temperature: temperature,
        updatedDate: updatedDate);
  }
}
