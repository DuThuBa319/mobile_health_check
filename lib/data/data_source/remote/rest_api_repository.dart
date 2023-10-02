import 'package:dio/dio.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/notification_onesignal_model/notification_onesignal_model.dart';
import 'package:retrofit/http.dart';
import '../../models/blood_pressure_model/blood_pressure_model.dart';
import '../../models/blood_sugar_model/blood_sugar_model.dart';
import '../../models/doctor_infor_model/doctor_infor_model.dart';
import '../../models/patient_infor_model/patient_infor_model.dart';
import '../../models/relative_model/relative_infor_model.dart';
import '../../models/spo2_model/spo2_model.dart';
import '../../models/temperature_model/temperature_model.dart';

part 'rest_api_repository.g.dart';

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  // @GET('/Users/AllPatients')
  // Future<List<PatientModel>> getPatientListModels();
//! Doctor ------------------------------
  @GET('/Users/DoctorInfo/{doctorId}') //để hiện detail
  Future<DoctorInforModel> getDoctorInforModel(
    @Path('doctorId') String? id,
  );
  @POST('/Users/{patientId}/AddNewRelative')
  Future<AccountModel> addRelativeInforModel(
      @Path('patientId') String? patientId,
      @Body() RelativeInforModel? relativeInforModel);
  @POST('/Users/{doctorId}/AddNewPatient')
  Future<AccountModel> addPatientInforModel(@Path('doctorId') String? doctorId,
      @Body() PatientInforModel? patientInforModel);
  @DELETE('/Users/{personId}') //delete
  Future<void> deletePerson(@Path('id') String? personId);
  @DELETE('/Users/DeletePatient/{patientId}') //delete
  Future<void> deletePatient(@Path('patientId') String? patientId);
  @PUT('/Users/{personId}/RemoveRelationship/{patientId}') //delete
  Future<void> deleteRelationship(
      @Path('personId') String? personId, @Path('patientId') String? patientId);
//! Relative ----------------------------
  @GET('/Users/RelativeInfo/{relativeId}') //để hiện detail
  Future<RelativeInforModel> getRelativeInforModel(
    @Path('relativeId') String? relativeId,
  );
  @PUT("/Users/{personId}") //update
  Future<void> updateRelativeInforModel(@Path("personId") String? id,
      @Body() RelativeInforModel? relativeInforModel);
//! Patient -----------------------------
  @GET('/Users/PatientInfo/{patientId}') //để hiện detail
  Future<PatientInforModel> getPatientInforModel(
    @Path('patientId') String? id,
  );

  @PUT("/Users/{personId}") //update
  Future<void> updatePatientInforModel(@Path("personId") String? id,
      @Body() PatientInforModel? patientInforModel);
  @PUT("/{id}") //update
  Future<void> updatePatient(
      @Path("id") int id, @Body() PatientInforModel patientInforModel);
//! Notification --------------------------------

  @GET('/Notification/{personId}') //để hiện detail
  Future<List<NotificationModel>> getNotificationListModels({
    @Path('personId') required String? personId,
    @Query('startIndex') required int? startIndex,
    @Query('lastIndex') required int? lastIndex,
  });
  @PUT("/Notification/{notificationId}") //update
  Future<void> setReadedNotificationModel(
      @Path("notificationId") String? notificationId);

  @GET('/Notification/{personId}/Unseen') //để hiện detail
  Future<int> getUnreadCountNotification(
    @Path('personId') String? personId,
  );

  @GET('/Notification/{personId}/Count') //để hiện detail
  Future<int> getNumberOfNotifications(
    @Path('personId') String? personId,
  );
  @DELETE('/Notification/{notificationId}') //delete
  Future<void> deleteNotificationModel(
      @Path('notificationId') String? notificationId);

//! BLOOD PRESSURE////////////////////////////
  @GET('/BloodPressures/{patientId}')
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  

  @POST('/BloodPressures/{id}')
  Future<bool> createBloodPressureModel(
      {@Path('id') required String id,
      @Body() required BloodPressureModel bloodPressureModel});

//! BLOOD SUGAR//////////////////////////////

  @GET('/BloodSugars/{patientId}')
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  
  @POST('/BloodSugars/{id}')
  Future<bool> createBloodSugarModel(
      {@Path('id') required String id,
      @Body() required BloodSugarModel bloodSugarModel});
//! BODYTEMERPATURE/////////////////////

  @GET('/BodyTemperatures/{patientId}')
  Future<List<TemperatureModel>> getListTemperatureModels({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @GET('/BodyTemperatures/{patientId}')
  
  @POST('/BodyTemperatures/{id}')
  Future<bool> createTemperatureModel(
      {@Path('id') required String id,
      @Body() required TemperatureModel temperatureModel});
//! SPO2/////////////////////
  @GET('/SpO2s/{patientId}')
  Future<List<Spo2Model>> getListSpo2Models({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  
  @POST('/SpO2s/{id}')
  Future<bool> createSpo2Model(
      {@Path('id') required String id, @Body() required Spo2Model spo2Model});
}
