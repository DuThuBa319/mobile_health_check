import 'package:dio/dio.dart';
import 'package:mobile_health_check/data/models/notification_onesignal_model/notification_onesignal_model.dart';
import 'package:retrofit/http.dart';
import '../../models/blood_pressure_model/blood_pressure_model.dart';
import '../../models/blood_sugar_model/blood_sugar_model.dart';
import '../../models/doctor_infor_model/doctor_infor_model.dart';
import '../../models/patient_infor_model/patient_infor_model.dart';
import '../../models/patient_list_model/patient_list_model.dart';
import '../../models/relative_model/relative_infor_model.dart';
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
  Future<PatientInforModel> addPatientInforModel(
      @Path('doctorId') String? doctorId,
      @Body() PatientInforModel? patientInforModel);

  @POST('/api/Persons/{patientId}/AddNewRelative')
  Future<RelativeInforModel> addRelativeInforModel(
      @Path('patientId') String? patientId,
      @Body() RelativeInforModel? relativeInforModel);

  @GET('/api/Persons/DoctorInfo/{doctorId}') //để hiện detail
  Future<DoctorInforModel> getDoctorInforModel(
    @Path('doctorId') String? id,
  );

  @GET('/api/Notification/{{doctorId}') //để hiện detail
  Future<List<NotificationModel>> getNotificationListModels(
    @Path('{doctorId') String? doctorId,
  );

  @PUT("/Persons/{personId}") //update
  Future<void> updatePatientInforModel(@Path("personId") String? id,
      @Body() PatientInforModel? patientInforModel);

  @PUT("/api/Notification/{notificationId}") //update
  Future<void> setReadedNotificationModel(
      @Path("notificationId") String? notificationId);

  @GET('/api/Notification/{doctorId}/Unseen') //để hiện detail
  Future<int?> getUnreadCountNotification(
    @Path('doctorId') String? doctorId,
  );

  @PUT("/{id}") //update
  Future<void> updatePatient(
      @Path("id") int id, @Body() PatientInforModel patientInforModel);

  @DELETE('/api/Persons/{personId}') //delete
  Future<void> deletePerson(@Path('id') String? personId);

  @PUT('/api/Persons/{personId}/RemoveRelationship/{patientId}') //delete
  Future<void> deleteRelationship(
      @Path('personId') String? personId, @Path('patientId') String? patientId);

//BLOOD PRESSURE////////////////////////////
  @GET('/{id}')
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    @Path('id') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @GET('/{id}')
  Future<BloodPressureModel> getBloodPressureModel({
    @Path('id') required int id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @POST('/{id}')
  Future<bool> createBloodPressureModel(
      {@Path('id') required String id,
      @Body() required BloodPressureModel bloodPressureModel});

//BLOOD SUGAR//////////////////////////////

  @GET('/{id}')
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    @Path('id') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @GET('/{id}')
  Future<BloodSugarModel> getBloodSugarModel({
    @Path('id') required int id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @POST('/{id}')
  Future<bool> createBloodSugarModel(
      {@Path('id') required String id,
      @Body() required BloodSugarModel bloodSugarModel});
// BODYTEMERPATURE/////////////////////

  @GET('/{id}')
  Future<List<TemperatureModel>> getListTemperatureModels({
    @Path('id') required String? id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @GET('/{id}')
  Future<TemperatureModel> getTemperatureModel({
    @Path('id') required int id,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });
  @POST('/{id}')
  Future<bool> createTemperatureModel(
      {@Path('id') required String id,
      @Body() required TemperatureModel temperatureModel});
}
