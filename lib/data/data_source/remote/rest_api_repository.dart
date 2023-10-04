import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'package:mobile_health_check/data/models/account_model/account_model.dart';
import 'package:mobile_health_check/data/models/notification_onesignal_model/notification_onesignal_model.dart';

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
  //? GET DOCTOR INFOR
  @GET('/Users/DoctorProfile/{doctorId}') //để hiện detail
  Future<DoctorInforModel> getDoctorInforModel(
    @Path('doctorId') String? doctorId,
  );

  //? UPDATE DOCTOR PROFILE
  @PATCH("/Users/UpdateProfile/{userId}") //update
  Future<void> updateDoctorInforModel(@Path("userId") String? doctorId,
      @Body() DoctorInforModel? doctorInforModel);

  //? ADD NEW PATIENT
  @POST('/Users/{doctorId}/CreatePatientAccount')
  Future<AccountModel> addPatientInforModel(@Path('doctorId') String? doctorId,
      @Body() PatientInforModel? patientInforModel);

  //? DELETE PATIENT
  @DELETE('/Users/DeletePatient/{patientId}') //delete
  Future<void> deletePatient(@Path('patientId') String? patientId);

  //? DELETE RELATIVE
  @DELETE('/Users/{patientId}/DeleteRelativeAccount/{relativeId}') //delete
  Future<void> deleteRelative(
      {@Path('patientId') String? patientId,
      @Path('relativeId') String? relativeId});

//! Relative ----------------------------
  //? GET RELATIVE INFOR
  @GET('/Users/RelativeProfile/{relativeId}') //để hiện detail
  Future<RelativeInforModel> getRelativeInforModel(
    @Path('relativeId') String? relativeId,
  );

  //? UPDATE RELATIVE PROFILE
  @PATCH("/Users/UpdateProfile/{userId}") //update
  Future<void> updateRelativeInforModel(@Path("userId") String? relativeId,
      @Body() RelativeInforModel? relativeInforModel);

//! Patient -----------------------------

  //? GET PATIENT INFOR
  @GET('/Users/PatientProfile/{patientId}') //để hiện detail
  Future<PatientInforModel> getPatientInforModel(
    @Path('patientId') String? patientId,
  );

  //? UPDATE PATIENT PROFILE
  @PATCH("/Users/UpdateProfile/{userId}") //update
  Future<void> updatePatientInforModel(@Path("userId") String? patientId,
      @Body() PatientInforModel? patientInforModel);

  //? ADD NEW RELATIVE
  @POST('/Users/{patientId}/CreateRelativeAccount')
  Future<AccountModel> addRelativeInforModel(
      @Path('patientId') String? patientId,
      @Body() RelativeInforModel? relativeInforModel);

//! Notification --------------------------------

  @GET('/Notifications/{personId}') //để hiện detail
  Future<List<NotificationModel>> getNotificationListModels({
    @Path('personId') required String? personId,
    @Query('startIndex') required int? startIndex,
    @Query('lastIndex') required int? lastIndex,
  });
  @PATCH("/Notifications/{notificationId}") //update
  Future<void> setReadedNotificationModel(
      @Path("notificationId") String? notificationId);

  @GET('/Notifications/{personId}/Unseen') //để hiện detail
  Future<int> getUnreadCountNotification(
    @Path('personId') String? personId,
  );

  @GET('/Notifications/{personId}/Count') //để hiện detail
  Future<int> getNumberOfNotifications(
    @Path('personId') String? userId,
  );
  @DELETE('/Notifications/{notificationId}') //delete
  Future<void> deleteNotificationModel(
      @Path('notificationId') String? notificationId);

//! BLOOD PRESSURE////////////////////////////
  @GET('/BloodPressures/{patientId}')
  Future<List<BloodPressureModel>> getListBloodPressureModels({
    @Path('patientId') required String? patientId,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @POST('/BloodPressures/{patientId}')
  Future<bool> createBloodPressureModel(
      {@Path('patientId') required String patientId,
      @Body() required BloodPressureModel bloodPressureModel});

//! BLOOD SUGAR//////////////////////////////

  @GET('/BloodSugars/{patientId}')
  Future<List<BloodSugarModel>> getListBloodSugarModels({
    @Path('patientId') required String? patientId,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @POST('/BloodSugars/{patientId}')
  Future<bool> createBloodSugarModel(
      {@Path('patientId') required String patientId,
      @Body() required BloodSugarModel bloodSugarModel});
//! BODYTEMERPATURE/////////////////////

  @GET('/BodyTemperatures/{patientId}')
  Future<List<TemperatureModel>> getListTemperatureModels({
    @Path('patientId') required String? patientId,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @POST('/BodyTemperatures/{patientId}')
  Future<bool> createTemperatureModel(
      {@Path('patientId') required String patientId,
      @Body() required TemperatureModel temperatureModel});
//! SPO2/////////////////////
  @GET('/SpO2s/{patientId}')
  Future<List<Spo2Model>> getListSpo2Models({
    @Path('patientId') required String? patientId,
    @Query('StartTime') DateTime? startTime,
    @Query('EndTime') DateTime? endTime,
  });

  @POST('/SpO2s/{patientId}')
  Future<bool> createSpo2Model(
      {@Path('patientId') required String patientId,
      @Body() required Spo2Model spo2Model});
}
