import 'package:common_project/data/models/temperature_model.dart';
import 'package:common_project/data/models/user_model.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/blood_pressure_model.dart';
import '../../models/blood_sugar_model.dart';

part 'rest_api_repository.g.dart';

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  @GET('')
  Future<List<UserModel>> getListUserModels({
    @Query('id') int? id,
    @Query('Age') int? age,
    @Query('Job') String? job,
    @Query('Name') String? name,
    @Query('Email') String? email,
    @Query('PhoneNumber') String? phonenumber,
  });

  @GET('/{id}') //để hiện detail
  Future<UserModel> getUserModel(
    @Path('id') int id,
  );

  @POST("") //regist
  Future<UserModel> registuser(@Body() UserModel userData);

  @PUT("/{id}") //update
  Future<void> updateUser(@Path("id") int id, @Body() UserModel userData);

  @DELETE('/{id}') //delete
  Future<void> deleteUser(@Path('id') int id);

  @GET('')
  Future<List<TemperatureModel>> getListTemperatureModels();
  @GET('/{id}')
  Future<TemperatureModel> getTemperatureModel({@Path('id') required int id});

  @GET('')
  Future<List<BloodPressureModel>> getListBloodPressureModels();
  @GET('/{id}')
  Future<BloodPressureModel> getBloodPressureModel(
      {@Path('id') required int id});
  @GET('')
  Future<List<BloodSugarModel>> getListBloodSugarModels();
  @GET('/{id}')
  Future<BloodSugarModel> getBloodSugarModel({@Path('id') required int id});
}
