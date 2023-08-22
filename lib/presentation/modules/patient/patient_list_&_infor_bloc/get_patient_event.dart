part of 'get_patient_bloc.dart';

@immutable
abstract class UserEvent {}

class GetListUserEvent extends UserEvent {
  GetListUserEvent();
}

class FilterUserEvent extends UserEvent {
  FilterUserEvent({required this.searchText});
  final String searchText;
}

class RegistUserEvent extends UserEvent {
  RegistUserEvent({required this.user});
  final UserModel user;
}

class GetUserDetailEvent extends UserEvent {
  final String id;
  GetUserDetailEvent({required this.id}) : super();
}

// class GetBloodPressureHistoryDataEvent extends UserEvent {
//   final DateTime startDate;
//   final DateTime endDate;
//   GetBloodPressureHistoryDataEvent(
//       {required this.endDate, required this.startDate});
// }

// class GetBloodPressureHistoryInitDataEvent extends UserEvent {
//   GetBloodPressureHistoryInitDataEvent();
// }

// class GetBloodSugarHistoryDataEvent extends UserEvent {
//   final DateTime startDate;
//   final DateTime endDate;
//   GetBloodSugarHistoryDataEvent(
//       {required this.endDate, required this.startDate});
// }

// class GetBloodSugarHistoryInitDataEvent extends UserEvent {
//   GetBloodSugarHistoryInitDataEvent();
// }

// class GetTemperatureHistoryDataEvent extends UserEvent {
//   final DateTime startDate;
//   final DateTime endDate;
//   GetTemperatureHistoryDataEvent(
//       {required this.endDate, required this.startDate});
// }

// class GetTemperatureHistoryInitDataEvent extends UserEvent {
//   GetTemperatureHistoryInitDataEvent();
// }

// class FilterUserEvent extends UserEvent {
//   FilterUserEvent({required this.searchText});
//   String searchText;
//   @override
//   List<Object> get props => [];
// }



