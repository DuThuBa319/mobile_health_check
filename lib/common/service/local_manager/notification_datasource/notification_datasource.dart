import '../../../../domain/entities/patient_infor_entity.dart';
import '../base_datasource.dart';

abstract class NotificationDataSource extends BaseDataSource {
  // Future<String?> getToken();

  // Future<void> setToken(String token);

  int? get unreadCount;
  int? get localeId;
  
  //! Id =1 => en
  //! Id =2 => vi

  // User? getUser();

  // Future<void> saveNotificationData(UserModel? user);
  Future<void> saveUnreadNotificationCount(int count);
  Future<void> increaseUnreadNotificationCount(); //Tăng số lượng unread,
  Future<void> decreaseUnreadNotificationCount();
  Future<void> saveLocale(int localeId);
  Future<void> savePatientId(String id);
  Future<void> savePatientName(String name);
  Future<void> savePatientAge(int age);
  Future<void> savePersonType(int personType);
  Future<void> savePatientWeight(double weight);
  Future<void> savePatientHeight(double height);
  Future<void> savePatientGender(int gender);
  Future<void> savePatientPhoneNumber(String phoneNumber);
  Future<void> savePatientStreet(String street);
  Future<void> savePatientWard(String ward);
  Future<void> savePatientDistrict(String district);
  Future<void> savePatientCity(String city);
  Future<void> savePatientCountry(String country);

  // Future<void> saveUserId(int userId);
}
