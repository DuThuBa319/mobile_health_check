
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/blood_pressure_model.dart';
import '../../models/blood_sugar_model.dart';
import '../../models/patient_infor_model.dart';
import '../../models/patient_list_model.dart';
import '../../models/temperature_model.dart';

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

  // @POST("") //regist
  // Future<PatientModel> registPatient(@Body() PatientModel patient);

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
