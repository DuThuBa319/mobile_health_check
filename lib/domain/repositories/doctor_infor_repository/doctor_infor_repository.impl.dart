// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'doctor_infor_repository.dart';

@Injectable(
  as: DoctorInforRepository,
)
class DoctorInforRepositoryImpl extends DoctorInforRepository {
  final DoctorInforApiRepository _doctorInforApi;

  DoctorInforRepositoryImpl(
    this._doctorInforApi,
  );
  @override
  Future<DoctorInforModel>? getDoctorInforModel(String? doctorId) {
    return _doctorInforApi.getDoctorInforModel(doctorId);
  }

  @override
  Future<void> addPatientInforModel(
      String? doctorId, PatientInforModel? patientInforModel) {
    return _doctorInforApi.addPatientInforModel(doctorId, patientInforModel);
  }

  @override
  Future<void> updateDoctorInforModel(String? doctorId,DoctorInforModel? doctorInforModel) {
    return _doctorInforApi.updateDoctorInforModel(doctorId,doctorInforModel);
  }

   @override
  Future<void> deletePatientModel( String? patientId) {
    return _doctorInforApi.deletePatientModel( patientId);
  }
 @override
  Future<void> deleteRelativeModel({String? relativeId,String? patientId}) {
    return _doctorInforApi.deleteRelativeModel(patientId:patientId ,relativeId:relativeId);
  }
}
