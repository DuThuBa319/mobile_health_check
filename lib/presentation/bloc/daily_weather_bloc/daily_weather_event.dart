part of 'daily_weather_bloc.dart';

@immutable
abstract class DailyWeatherEvent {}

class GetDailyWeatherEvent extends DailyWeatherEvent {
  GetDailyWeatherEvent({
    required this.startDate,
    required this.endDate,
    required this.latitude,
    required this.longtitude,
  });
  final String startDate;
  final String endDate;
  final String latitude;
  final String longtitude;
}
