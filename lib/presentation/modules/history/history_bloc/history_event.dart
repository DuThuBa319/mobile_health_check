part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class GetBloodPressureHistoryDataEvent extends HistoryEvent {
  final String? id;
  final DateTime startTime;
  final DateTime endTime;
  GetBloodPressureHistoryDataEvent(
      {required this.endTime, required this.startTime, required this.id});
}

class GetBloodPressureHistoryInitDataEvent extends HistoryEvent {
  final String? id;
  final DateTime startTime;
  final DateTime endTime;
  GetBloodPressureHistoryInitDataEvent(
      {required this.endTime, required this.startTime, required this.id});
}

class GetBloodSugarHistoryDataEvent extends HistoryEvent {
  final String? id;
  final DateTime startTime;
  final DateTime endTime;
  GetBloodSugarHistoryDataEvent(
      {required this.endTime, required this.startTime, required this.id});
}

class GetBloodSugarHistoryInitDataEvent extends HistoryEvent {
  final String? id;
  final DateTime startTime;
  final DateTime endTime;
  GetBloodSugarHistoryInitDataEvent({required this.endTime, required this.startTime, required this.id});
}

class GetTemperatureHistoryDataEvent extends HistoryEvent {
 final String? id;
  final DateTime startTime;
  final DateTime endTime;
  GetTemperatureHistoryDataEvent(
      {required this.endTime, required this.startTime, required this.id});
}

class GetTemperatureHistoryInitDataEvent extends HistoryEvent {
   final String? id;
  final DateTime startTime;
  final DateTime endTime;
  GetTemperatureHistoryInitDataEvent({required this.endTime, required this.startTime, required this.id});
}
