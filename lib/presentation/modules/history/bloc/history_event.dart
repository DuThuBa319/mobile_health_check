part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class GetHistoryDataEvent extends HistoryEvent {
  final DateTime startDate;
  final DateTime endDate;
  GetHistoryDataEvent({required this.endDate, required this.startDate});
}
