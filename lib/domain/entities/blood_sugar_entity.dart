import 'package:flutter/material.dart';

import '../../classes/language_constant.dart';
import '../../data/models/blood_sugar_model.dart';

class BloodSugarEntity {
  double? bloodSugar;
  String? imageLink;
  DateTime? updatedDate;

  BloodSugarEntity({this.imageLink, this.updatedDate, this.bloodSugar});
  Color? get statusColor {
    if (bloodSugar != null) {
      if (bloodSugar! <= 70) {
        //|| dia! <= 60
        return Colors.blue;
      } else if (80 <= bloodSugar! && bloodSugar! <= 100) {
        //|| dia! <= 80
        return const Color.fromARGB(255, 64, 247, 70);
      } else if (bloodSugar! >= 101 && bloodSugar! <= 125) {
        //|| dia! >= 80 && dia! <= 89
        return Colors.orange;
      } else if (bloodSugar! >= 126) {
        //|| dia! >= 90 && dia! <= 99
        return Colors.red;
      }
    }

    return Colors.grey;
  }

  String statusComment(BuildContext context) {
    if (bloodSugar != null) {
      if (bloodSugar! <= 70) {
        //|| dia! <= 60
        return translation(context).hypoglycemia;
      } else if (bloodSugar! >= 80 && bloodSugar! <= 100) {
        //|| dia! >= 80 && dia! <= 89
        return translation(context).normalBS; //  Đường huyết cao
      } else if (bloodSugar! >= 101 && bloodSugar! <= 125) {
        //|| dia! >= 90 && dia! <= 99
        return translation(context).prediabetes;
      } else if (bloodSugar! >= 126) {
        //|| dia! >= 100 && dia! <= 109
        return translation(context).hyperglycemia;
      }
    }

    return '--';
  }

  BloodSugarModel getBloodSugarModel() {
    return BloodSugarModel(
        imageLinkBloodSugar: imageLink,
        bloodSugar: bloodSugar,
        updatedDate: updatedDate);
  }
}
