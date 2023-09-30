import 'package:dio/dio.dart';
import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/notification_onesignal_model/notification_onesignal_model.dart';
import 'package:retrofit/http.dart';
import '../../models/blood_pressure_model/blood_pressure_model.dart';
import '../../models/blood_sugar_model/blood_sugar_model.dart';
import '../../models/doctor_infor_model/doctor_infor_model.dart';
import '../../models/number_of_notifications/number_of_notifications_model.dart';
import '../../models/patient_infor_model/patient_infor_model.dart';
import '../../models/relative_model/relative_infor_model.dart';
import '../../models/spo2_model/spo2_model.dart';
import '../../models/temperature_model/temperature_model.dart';

part 'rest_api_repository.g.dart';

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  // @GET('/Persons/AllPatients')
  // Future<List<PatientModel>> getPatientListModels();

  @GET('/api/Persons/PatientInfo/{patientId}') //để hiện detail
  Future<PatientInforModel> getPatientInforModel(
    @Path('patientId') String? id,
  );

  @POST('/api/Persons/{doctorId}/AddNewPatient')
  Future<AccountModel> addPatientInforModel(@Path('doctorId') String? doctorId,
      @Body() PatientInforModel? patientInforModel);

  @POST('/api/Persons/{patientId}/AddNewRelative')
  Future<AccountModel> addRelativeInforModel(
      @Path('patientId') String? patientId,
      @Body() RelativeInforModel? relativeInforModel);

  @GET('/api/Persons/DoctorInfo/{doctorId}') //để hiện detail
  Future<DoctorInforModel> getDoctorInforModel(
    @Path('doctorId') String? id,
  );
  @GET('/api/Persons/RelativeInfo/{relativeId}') //để hiện detail
  Future<RelativeInforModel> getRelativeInforModel(
    @Path('relativeId') String? relativeId,
  );

  @GET('/api/Notification/{doctorId}') //để hiện detail
  Future<List<NotificationModel>> getNotificationListModels({
    @Path('doctorId') required String? doctorId,
    @Query('startIndex') required int? startIndex,
    @Query('lastIndex') required int? lastIndex,
  });

  @PUT("/api/Persons/{personId}") //update
  Future<void> updatePatientInforModel(@Path("personId") String? id,
      @Body() PatientInforModel? patientInforModel);
  @PUT("/api/Persons/{personId}") //update
  Future<void> updateRelativeInforModel(@Path("personId") String? id,
      @Body() RelativeInforModel? relativeInforModel);

  @PUT("/api/Notification/{notificationId}") //update
  Future<void> setReadedNotificationModel(
      @Path("notificationId") String? notificationId);

  @GET('/api/Notification/{doctorId}/Unseen') //để hiện detail
  Future<int?> getUnreadCountNotification(
    @Path('doctorId') String? doctorId,
  );

  @GET('/api/Notification/{doctorId}/Count') //để hiện detail
  Future<NumberOfNotificationsModel> getNumberOfNotifications(
    @Path('doctorId') String? doctorId,
  );
  @DELETE('/api/Notification/{notificationId}') //delete
  Future<void> deleteNotificationModel(
      @Path('notificationId') String? notificationId);

  @PUT("/{id}") //update
  Future<void> updatePatient(
      @Path("id") int id, @Body() PatientInforModel patientInforModel);

  @DELETE('/api/Persons/{personId}') //delete
  Future<void> deletePerson(@Path('id') String? personId);

  @DELETE('/api/Persons/DeletePatient/{patientId}') //delete
  Future<void> deletePatient(@Path('patientId') String? patientId);

  @PUT('/api/Persons/{personId}/RemoveRelationship/{patientId}') //delete
  Future<void> deleteRelationship(
      @Path('personId') String? personId, @Path('patientId') String? patientId);

//BLOOD PRESSURE////////////////////////////
  @GET('/{patientId}')
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @GET('/{patientId}')
  Future<BloodPressureModel> getBloodPressureModel({
    @Path('patientId') required int id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @POST('/{id}')
  Future<bool> createBloodPressureModel(
      {@Path('id') required String id,
      @Body() required BloodPressureModel bloodPressureModel});

//BLOOD SUGAR//////////////////////////////

  @GET('/{patientId}')
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @GET('/{patientId}')
  Future<BloodSugarModel> getBloodSugarModel({
    @Path('patientId') required int id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @POST('/{id}')
  Future<bool> createBloodSugarModel(
      {@Path('id') required String id,
      @Body() required BloodSugarModel bloodSugarModel});
// BODYTEMERPATURE/////////////////////

  @GET('/{patientId}')
  Future<List<TemperatureModel>> getListTemperatureModels({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @GET('/{patientId}')
  Future<TemperatureModel> getTemperatureModel({
    @Path('patientId') required int id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @POST('/{id}')
  Future<bool> createTemperatureModel(
      {@Path('id') required String id,
      @Body() required TemperatureModel temperatureModel});

  @GET('/{patientId}')
  Future<List<Spo2Model>> getListSpo2Models({
    @Path('patientId') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @GET('/{patientId}')
  Future<Spo2Model> getSpo2Model({
    @Path('patientId') required int id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @POST('/{id}')
  Future<bool> createSpo2Model(
      {@Path('id') required String id, @Body() required Spo2Model spo2Model});
// BODYTEMERPATURE/////////////////////
}
