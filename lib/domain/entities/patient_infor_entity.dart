import 'package:mobile_health_check/domain/entities/temperature_entity.dart';

import '../../common/service/local_manager/user_data_datasource/user.dart';
import 'blood_pressure_entity.dart';
import 'blood_sugar_entity.dart';

class PatientInforEntity {
  String id;
  String name;
  int? age;
  int? personType;
  double? weight;
  double? height;
  bool? gender;
  String phoneNumber;
  String? avatarPath;
  String? address;
  List<TemperatureEntity>? bodyTemperatures;
  List<BloodSugarEntity>? bloodSugars;
  List<BloodPressureEntity>? bloodPressures;

  PatientInforEntity({
    this.gender,
    this.bloodPressures,
    this.bloodSugars,
    this.bodyTemperatures,
    this.address,
    required this.id,
    required this.name,
    this.age,
    this.personType,
    this.weight,
    this.height,
    required this.phoneNumber,
    this.avatarPath,
  });

  User convertUser({required User user}) {
    return user.copyWith(
        gender: gender,
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        age: age,
        address: address,
        height: height,
        weight: weight);
  }

  //  Color get statusColor {
  //   if (sys != null && dia != null) {
  //     if (sys! <= 90) {
  //       //|| dia! <= 60
  //       return Colors.blue;
  //     } else if (sys! <= 120) {
  //       //|| dia! <= 80
  //       return const Color.fromARGB(255, 64, 247, 70);
  //     } else if (sys! >= 120 && sys! <= 139) {
  //       //|| dia! >= 80 && dia! <= 89
  //       return Colors.orange;
  //     } else if (sys! >= 140 && sys! <= 159) {
  //       //|| dia! >= 90 && dia! <= 99
  //       return Colors.red;
  //     } else if (sys! >= 160 && sys! <= 179) {
  //       //|| dia! >= 100 && dia! <= 109
  //       return Colors.red;
  //     } else if (sys! >= 180) {
  //       //|| dia! >= 110
  //       return Colors.red;
  //     }
  //   }

  //   return Colors.grey;
  // }

  //   return PatientInforModel(
  //     id: id,
  //     age: age,
  //     name: name,
  //     phoneNumber: phoneNumber,
  //     avatarPath: avatarPath,
  //     address: address,
  //     bloodPressures: bloodPressureModels,
  //     bloodSugars: bloodSugarModels,
  //     height: height,
  //     personType: personType,
  //    bodyTemperatures: temperatureModels,
  //     weight: weight,
  //   );
  // }
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity