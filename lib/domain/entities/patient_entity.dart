import 'package:mobile_health_check/data/models/blood_sugar_model.dart';
import 'package:mobile_health_check/data/models/temperature_model.dart';
import 'package:mobile_health_check/data/models/patient_list_model.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';

import '../../data/models/blood_pressure_model.dart';
import '../../data/models/patient_infor_address_model.dart';
import 'blood_pressure_entity.dart';
import 'blood_sugar_entity.dart';

class UserEntity {
  String id;
  String name;
  // int? age;
  // int? personType;
  // double? weight;
  // double? height;
  String phoneNumber;
  // String? avatarPath;
  // UserAddressModel? address;
  // List<TemperatureEntity>? bodyTemperatures;
  // List<BloodSugarEntity>? bloodSugars;
  // List<BloodPressureEntity>? bloodPressures;

  UserEntity({
    // this.bloodPressures,
    // this.bloodSugars,
    // this.bodyTemperatures,
    // this.address,
    required this.id,
    required this.name,
    // this.age,
    // this.personType,
    // this.weight,
    // this.height,
    required this.phoneNumber,
    // this.avatarPath,
  });
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
  // UserModel getUserModel() {
  //   List<BloodPressureModel> bloodPressureModels = [];
  //   if (bloodPressures != null) {
  //     for (var model in bloodPressures!) {
  //       bloodPressureModels.add(model.getBloodPressureModel());
  //     }
  //   }
  //   List<BloodSugarModel> bloodSugarModels = [];
  //   if (bloodSugars != null) {
  //     for (var model in bloodSugars!) {
  //       bloodSugarModels.add(model.getBloodSugarModel());
  //     }
  //   }
  //   List<TemperatureModel> temperatureModels = [];
  //   if (temperatures != null) {
  //     for (var model in temperatures!) {
  //       temperatureModels.add(model.getTemperatureModel());
  //     }
  //   }

  //   return UserModel(
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