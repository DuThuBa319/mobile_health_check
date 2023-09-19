import 'package:flutter/material.dart';

import '../../classes/language_constant.dart';
import '../../data/models/blood_pressure_model/blood_pressure_model.dart';

class BloodPressureEntity {
  int? sys;
  int? pulse;
  String? imageLink;
  DateTime? updatedDate;

  BloodPressureEntity({
    this.sys,
    this.pulse,
    this.imageLink,
    this.updatedDate,
  });
  BloodPressureEntity copywith({
    int? sys,
    int? pulse,
    String? imageLink,
    DateTime? updatedDate,
  }) {
    return BloodPressureEntity(
        sys: sys ?? this.sys,
        pulse: pulse ?? this.pulse,
        imageLink: imageLink ?? this.imageLink,
        updatedDate: updatedDate ?? this.updatedDate);
  }

  Color get statusColor {
    if (sys != null ) {
     if (sys! <= 120) {
        //|| dia! <= 80
        return const Color.fromARGB(255, 64, 247, 70);
      } else if (sys! >= 120 && sys! <= 139) {
        //|| dia! >= 80 && dia! <= 89
        return Colors.orange;
      } else if (sys! >= 140 && sys! <= 159) {
        //|| dia! >= 90 && dia! <= 99
        return Colors.red;
      } else if (sys! >= 160 && sys! <= 179) {
        //|| dia! >= 100 && dia! <= 109
        return Colors.red;
      } else if (sys! >= 180) {
        //|| dia! >= 110
        return Colors.red;
      }
    }

    return Colors.grey;
  }

  String statusComment(BuildContext context) {
    if (sys != null ) {
      if (sys! <= 90) {
        //|| dia! <= 60
        return translation(context).hypotension;
        // huyết áp thấp
      } else if (sys! <= 120) {
        // || dia! <= 80
        return translation(context).normalBP;
        //Huyết áp bình thường
      } else if (sys! >= 120 && sys! <= 139) {
        //|| dia! >= 80 && dia! <= 89
        return translation(context).prehypertension;
        // tiền huyết áp cao
      } else if (sys! >= 140 && sys! <= 159) {
        //|| dia! >= 90 && dia! <= 99
        return translation(context).stage1hypertension;
        // huyết áp cấp độ 1
      } else if (sys! >= 160 && sys! <= 179) {
        //|| dia! >= 100 && dia! <= 109
        return translation(context).stage2hypertension;
      } else if (sys! >= 180) {
        //|| dia! >= 110
        return translation(context).stage3hypertension;
      }
    }

    return '--';
  }

  BloodPressureModel getBloodPressureModel() {
    return BloodPressureModel(
        sys: sys,
        pulse: pulse,
        imageLinkBloodPressure: imageLink,
        updatedDate: updatedDate);
  }
}
