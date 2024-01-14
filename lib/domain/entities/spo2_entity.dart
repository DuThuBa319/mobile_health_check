import 'package:flutter/material.dart';
import 'package:mobile_health_check/classes/language.dart';

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
      if (spo2! >= 95) {
        return const Color.fromARGB(255, 64, 247, 70);
      } else if (spo2! < 95) {
        //|| dia! >= 90 && dia! <= 99
        return Colors.red;
      }
    }
    return null;
  }

  String statusComment(BuildContext context) {
    if (spo2 != null) {
      if (spo2! < 90) {
        return translation(context).emergencySpo2;
      } else if (97 <= spo2! && spo2! <= 99) {
        return translation(context).goodSpo2;
      } else if (spo2! >= 94 && spo2! <= 96) {
        return translation(context).averageSpo2;
      } else if (spo2! >= 93 && spo2! <= 90) {
        return translation(context).lowSpo2;
      }
    }

    return '--';
  }
}
