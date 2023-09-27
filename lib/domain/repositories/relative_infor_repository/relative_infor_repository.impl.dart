// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'relative_infor_repository.dart';

@Injectable(
  as: RelativeInforRepository,
)
class RelativeInforRepositoryImpl extends RelativeInforRepository {
  final RelativeInforApiRepository _relativeInforApi;

  RelativeInforRepositoryImpl(
    this._relativeInforApi,
  );
  @override
  Future<RelativeInforModel>? getRelativeInforModel(String? relativeId) {
    return _relativeInforApi.getRelativeInforModel(relativeId);
  }
  @override
  Future<void> updateRelativeInforModel(String? id,RelativeInforModel? relativeInforModel) {
    return _relativeInforApi.updateRelativeInforModel(id,relativeInforModel);
  }
}
