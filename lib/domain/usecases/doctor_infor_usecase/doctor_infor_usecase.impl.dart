part of 'doctor_infor_usecase.dart';

@Injectable(
  as: DoctorInforUsecase,
)
class DoctorInforUsecaseImpl extends DoctorInforUsecase {
  final DoctorInforRepository _repository;

  DoctorInforUsecaseImpl(this._repository);

  @override
  Future<DoctorInforEntity?>? getDoctorInforEntity(String? id) async {
    final response = await _repository.getDoctorInforModel(id);
    final entity = response?.getDoctorInforEntity();
    return entity;
  }
}
