import 'package:dio/dio.dart';
import 'package:mobile_health_check/data/models/notification_onesignal_model/notification_onesignal_model.dart';
import 'package:retrofit/http.dart';
import '../../models/blood_pressure_model/blood_pressure_model.dart';
import '../../models/blood_sugar_model/blood_sugar_model.dart';
import '../../models/doctor_infor_model/doctor_infor_model.dart';
import '../../models/patient_infor_model/patient_infor_model.dart';
import '../../models/patient_list_model/patient_list_model.dart';
import '../../models/temperature_model/temperature_model.dart';


part 'rest_api_repository.g.dart';

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  @GET('/Persons/AllPatients')
  Future<List<PatientModel>> getPatientListModels();

  @GET('/Persons/PatientInfo/{id}') //để hiện detail
  Future<PatientInforModel> getPatientInforModel(
    @Path('id') String? id,
  );

 @GET('/Persons/DoctorInfo/{id}') //để hiện detail
  Future<DoctorInforModel> getDoctorInforModel(
    @Path('id') String? id,
  );

@GET('/api/Notification/{id}') //để hiện detail
  Future<List<NotificationModel>> getNotificationListModels(
    @Path('id') String? id,
  );

  
@PUT("/api/Notification/{notificationId}/seen") //update
  Future<void> setReadedNotificationModel(@Path("notificationId") String? notificationId);




  @PUT("/{id}") //update
  Future<void> updatePatient(@Path("id") int id, @Body() PatientModel patient);

  @DELETE('/{id}') //delete
  Future<void> deletePatient(@Path('id') int id);

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
