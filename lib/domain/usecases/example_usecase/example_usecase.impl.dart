part of 'example_usecase.dart';

@Injectable(
  as: ExampleUsecase,
)
class ExampleUsecaseImpl extends ExampleUsecase {
  final WeatherRepository _repository;

  ExampleUsecaseImpl(this._repository);

  @override
  Future<List<DailyWeatherEntity>?> getWeatherEntity({
    String latitude = '10.82',
    String longtitude = '106.83',
    String startDate = '2023-01-01',
    String endDate = '2023-02-08',
  }) async {
    final response = await _repository.getWeatherModel(
      latitude: latitude,
      longtitude: longtitude,
      startDate: startDate,
      endDate: endDate,
    );
    final dailyWeatherEntity =
        response.dailyWeatherModel?.getDailyWeatherEntites();
    return dailyWeatherEntity;
  }
}
