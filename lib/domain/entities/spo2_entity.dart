import 'package:flutter/material.dart';

import '../../data/models/spo2_model/spo2_model.dart';

class Spo2Entity {
  int? spo2;
  String? imageLink;
  DateTime? updatedDate;

  Spo2Entity({this.imageLink, this.updatedDate, this.spo2});
  Spo2Entity copywith({
    int? spo2,
    String? imageLink,
    DateTime? updatedDate,
  }) {
    return Spo2Entity(
        spo2: spo2 ?? this.spo2,
        imageLink: imageLink ?? this.imageLink,
        updatedDate: updatedDate ?? this.updatedDate);
  }

  Spo2Model getSpo2Model() {
    return Spo2Model(
        imageLinkSpo2: imageLink, spo2: spo2, updatedDate: updatedDate);
  }

  Color? get statusColor {
    if (spo2 != null) {
      if (spo2! < 35.9) {
        //|| dia! <= 60
        return Colors.blue;
      } else if (36 <= spo2! && spo2! <= 36.9) {
        //|| dia! <= 80
        return const Color.fromARGB(255, 64, 247, 70);
      } else if (spo2! >= 37 && spo2! <= 38) {
        //|| dia! >= 80 && dia! <= 89
        return Colors.orange;
      } else if (spo2! >= 38.1) {
        //|| dia! >= 90 && dia! <= 99
        return Colors.red;
      }
    }
    return null;
  }
}
