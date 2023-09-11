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
  Future<DoctorInforModel>? getDoctorInforModel(String? id) {
    return _doctorInforApi.getDoctorInforModel(id);
  }

  
}

