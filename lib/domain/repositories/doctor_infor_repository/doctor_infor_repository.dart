//repo này gọi đến rôp rest_api trên kia

import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';

import '../../../data/data_source/remote/module_repositories/doctor_infor_api_repository/doctor_api_repository.dart';
import '../../../data/models/doctor_infor_model/doctor_infor_model.dart';
part 'doctor_infor_repository.impl.dart';

abstract class DoctorInforRepository {
  Future<DoctorInforModel>? getDoctorInforModel(String? doctorId);
  Future<void> addPatientInforModel(
      String? doctorId, AccountModel? accountModel);
  Future<void> updateDoctorInforModel(
      String? doctorId, DoctorInforModel? doctorInforModel);
      
  Future<void> deletePatientModel(String? patientId);
  Future<void> deleteRelativeModel({String? relativeId, String? patientId});
}
