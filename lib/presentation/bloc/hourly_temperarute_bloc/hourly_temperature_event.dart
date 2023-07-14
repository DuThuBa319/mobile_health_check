part of 'hourly_temperature_bloc.dart';

@immutable
abstract class HourlyTemperatureEvent {}

class GetHourlyTemperatureEvent extends HourlyTemperatureEvent {
GetHourlyTemperatureEvent ({
    required this.startDate,
    required this.endDate,
    required this.latitude,
    required this.longitude,
  });
  final String startDate;
  final String endDate;
  final String latitude;
  final String longitude;
}
