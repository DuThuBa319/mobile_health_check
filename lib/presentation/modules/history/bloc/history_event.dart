part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class GetBloodPressureHistoryDataEvent extends HistoryEvent {
  final DateTime startDate;
  final DateTime endDate;
  GetBloodPressureHistoryDataEvent(
      {required this.endDate, required this.startDate});
}

class GetBloodPressureHistoryInitDataEvent extends HistoryEvent {
  GetBloodPressureHistoryInitDataEvent();
}

class GetBloodSugarHistoryDataEvent extends HistoryEvent {
  final DateTime startDate;
  final DateTime endDate;
  GetBloodSugarHistoryDataEvent(
      {required this.endDate, required this.startDate});
}

class GetBloodSugarHistoryInitDataEvent extends HistoryEvent {
  GetBloodSugarHistoryInitDataEvent();
}

class GetTemperatureHistoryDataEvent extends HistoryEvent {
  final DateTime startDate;
  final DateTime endDate;
  GetTemperatureHistoryDataEvent(
      {required this.endDate, required this.startDate});
}

class GetTemperatureHistoryInitDataEvent extends HistoryEvent {
  GetTemperatureHistoryInitDataEvent();
}
