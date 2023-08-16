import 'package:flutter/material.dart';

import '../../data/models/blood_pressure_model.dart';

class BloodPressureEntity {
  int? sys;
  int? dia;
  int? pulse;
  String? imageLink;
  DateTime? updatedDate;

  BloodPressureEntity({
    this.sys,
    this.dia,
    this.pulse,
    this.imageLink,
    this.updatedDate,
  });

  Color get statusColor {
    if (sys != null && dia != null) {
      if (sys! <= 90) {
        //|| dia! <= 60
        return Colors.blue;
      } else if (sys! <= 120) {
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

  String get comment {
    if (sys != null && dia != null) {
      if (sys! <= 90) {
        //|| dia! <= 60
        return "Huyết áp thấp";
      } else if (sys! <= 120) {
        // || dia! <= 80
        return 'Huyết áp bình thường';
      } else if (sys! >= 120 && sys! <= 139) {
        //|| dia! >= 80 && dia! <= 89
        return 'Tiền huyết áp cao'; // tiền huyết áp cao
      } else if (sys! >= 140 && sys! <= 159) {
        //|| dia! >= 90 && dia! <= 99
        return 'Huyết áp cấp độ 1';
      } else if (sys! >= 160 && sys! <= 179) {
        //|| dia! >= 100 && dia! <= 109
        return 'Huyết áp cấp độ 2';
      } else if (sys! >= 180) {
        //|| dia! >= 110
        return 'Huyết áp cấp độ 3';
      }
    }

    return '--';
  }

  BloodPressureModel getBloodPressureModel() {
    return BloodPressureModel(
        dia: dia,
        sys: sys,
        pulse: pulse,
        imageLink: imageLink,
        updatedDate: updatedDate);
  }
}
