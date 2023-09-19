import 'package:injectable/injectable.dart';

import '../../../data/data_source/remote/module_repositories/blood_sugar_api_repositoy/blood_sugar_api_repository.dart';
import '../../../data/data_source/remote/module_repositories/spo2_api_repositoy/spo2_api_repository.dart';
import '../../../data/models/blood_sugar_model/blood_sugar_model.dart';
import '../../../data/models/spo2_model/spo2_model.dart';

part 'spo2_repository.impl.dart';

//repo này gọi đến rôp rest_api trên kia
abstract class Spo2Repository {
  Future<List<Spo2Model>> getListSpo2Models({
    required String? id,
    DateTime? startTime,
    DateTime? endTime,
  });
  Future<Spo2Model> getSpo2Model({required int id});
  Future<bool> createSpo2Model(
      {required String id, required Spo2Model spo2Model});
}
