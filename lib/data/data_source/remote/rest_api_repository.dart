import 'package:mobile_health_check/data/models/patient_list_model.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/blood_pressure_model.dart';
import '../../models/blood_sugar_model.dart';
import '../../models/patient_infor_model.dart';
import '../../models/temperature_model.dart';

part 'rest_api_repository.g.dart';

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  @GET('/Persons/AllPatients')
  Future<List<UserModel>> getListUserModels();

  @GET('/Persons/PatientInfo/{id}') //để hiện detail
  Future<PatientInforModel> getPatientInforModel(
    @Path('id') String? id,
  );

  @POST("") //regist
  Future<UserModel> registuser(@Body() UserModel userData);

  @PUT("/{id}") //update
  Future<void> updateUser(@Path("id") int id, @Body() UserModel userData);

  @DELETE('/{id}') //delete
  Future<void> deleteUser(@Path('id') int id);

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

  @POST('')
  Future<BloodPressureModel> createBloodPressureModel(
      {@Body() required BloodPressureModel bloodPressureModel});

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
}
