import 'package:common_project/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'rest_api_repository.g.dart';

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  @GET('')
  Future<List<UserModel>> getListUserModels();
  @GET('/{id}')
  Future<UserModel> getUserModel(
    @Path('id') String id,
  );
}
