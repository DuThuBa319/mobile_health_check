import 'package:flutter/material.dart';

import '../../data/models/blood_pressure_model.dart';

class BloodPressureEntity {
  int? id;
  int? sys;
  int? dia;
  int? pulse;
  DateTime? updatedDate;
  String? imageUrl;
  BloodPressureEntity(
      {this.dia,
      this.pulse,
      this.sys,
      this.updatedDate,
      this.id,
      this.imageUrl});

  String get comment {
    if (sys != null && dia != null) {
      if (sys! <= 90) {
        //|| dia! <= 60
        return 'Low Blood Pressure';
      } else if (sys! <= 120) {
        // || dia! <= 80
        return 'Good Blood Pressure';
      } else if (sys! >= 120 && sys! <= 139) {
        //|| dia! >= 80 && dia! <= 89
        return 'Elevated Blood Pressure'; // tiền huyết áp cao
      } else if (sys! >= 140 && sys! <= 159) {
        //|| dia! >= 90 && dia! <= 99
        return 'Hypertension Stage 1';
      } else if (sys! >= 160 && sys! <= 179) {
        //|| dia! >= 100 && dia! <= 109
        return 'Hypertension Stage 2';
      } else if (sys! >= 180) {
        //|| dia! >= 110
        return 'Hypertension Stage 3';
      }
    }

    return '--';
  }

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

  BloodPressureModel getBloodPressureModel() {
    return BloodPressureModel(
        id: id,
        sys: sys.toString(),
        dia: dia.toString(),
        pulse: pulse.toString(),
        imageUrl: imageUrl,
        updatedDate: updatedDate);
  }
}
