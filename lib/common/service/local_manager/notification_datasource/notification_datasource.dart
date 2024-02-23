import '../base_datasource.dart';

abstract class NotificationDataSource extends BaseDataSource {
  // Future<String?> getToken();

  // Future<void> setToken(String token);

  int? get delayTime;
  int? get localeId;

  //! Id =1 => en
  //! Id =2 => vi

  Future<void> saveDelayTime(int delayTime);
  Future<void> saveLocale(int localeId);
}
