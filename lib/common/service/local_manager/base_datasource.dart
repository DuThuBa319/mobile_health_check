import '../../../../di/di.dart';

import 'local_data_manager.dart';

abstract class BaseDataSource {
  LocalDataManager get localDataManager => injector<LocalDataManager>();

  Future<void> clearData();
}
