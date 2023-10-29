import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../../domain/entities/spo2_entity.dart';
import '../../../../domain/entities/temperature_entity.dart';
import '../../../../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart';
import '../../../../domain/usecases/spo2_usecase/spo2_usecase.dart';
import '../../../../domain/usecases/temperature_usecase/temperature_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final BloodPressureUsecase bloodPressureUseCase;
  final BloodSugarUsecase bloodSugarUseCase;
  final TemperatureUsecase temperatureUsecase;
  final Spo2Usecase spo2Usecase;
  final Connectivity _connectivity;

  HistoryBloc(this.bloodPressureUseCase, this.bloodSugarUseCase,
      this.temperatureUsecase, this.spo2Usecase, this._connectivity)
      : super(HistoryInitialState()) {
    on<GetBloodPressureHistoryDataEvent>(_onGetBloodPressureHistoryData);
    on<GetBloodSugarHistoryDataEvent>(_onGetBloodSugarHistoryData);
    on<GetTemperatureHistoryDataEvent>(_onGetTemperatureHistoryData);
    on<GetSpo2HistoryDataEvent>(_onGetSpo2HistoryData);
    // on<GetBloodPressureHistoryInitDataEvent>(
    //     _onGetBloodPressureHistoryInitData);
    // on<GetBloodSugarHistoryInitDataEvent>(_onGetBloodSugarHistoryInitData);
    // on<GetTemperatureHistoryInitDataEvent>(_onGetTemperatureHistoryInitData);
    // on<GetSpo2HistoryInitDataEvent>(_onGetSpo2HistoryInitData);
  }

  ///
  Future<void> _onGetBloodPressureHistoryData(
    GetBloodPressureHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final responses =
            await bloodPressureUseCase.getListBloodPressureEntities(
                patientId: event.id,
                endTime: event.endTime,
                startTime: event.startTime);

        List<BloodPressureEntity>? listBloodPressure = [];
        for (var response in responses) {
          if (response.updatedDate!.isAfter(event.startTime) &&
              response.updatedDate!.isBefore(event.endTime)) {
            listBloodPressure.add(response);
          }
        }
        final newViewModel =
            state.viewModel.copyWith(listBloodPressure: listBloodPressure);
        emit(
          state.copyWith(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel,
          ),
        );
      }
    } else {
      emit(
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  ////
//   Future<void> _onGetBloodPressureHistoryInitData(
//     GetBloodPressureHistoryInitDataEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     final connectivityResult = await _connectivity.checkConnectivity();
//     if (connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.mobile) {
//       emit(
//         GetHistoryDataState(
//           status: BlocStatusState.loading,
//           viewModel: state.viewModel,
//         ),
//       );
//       try {
//         final responses =
//             await bloodPressureUseCase.getListBloodPressureEntities(
//                patientId: event.id,
//                 endTime: event.endTime,
//                 startTime: event.startTime);
//         List<BloodPressureEntity>? listBloodPressure = [];
//         for (var response in responses) {
//           listBloodPressure.add(response);
//         }
//         final newViewModel =
//             state.viewModel.copyWith(listBloodPressure: listBloodPressure);
//         emit(
//           state.copyWith(
//             status: BlocStatusState.success,
//             viewModel: newViewModel,
//           ),
//         );
//       } catch (e) {
//         emit(
//           state.copyWith(
//             status: BlocStatusState.failure,
//             viewModel: state.viewModel,
//           ),
//         );
//       }
//     } else {
//       emit(
//         WifiDisconnectState(
//           status: BlocStatusState.success,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }

//   ///

//   Future<void> _onGetBloodSugarHistoryInitData(
//     GetBloodSugarHistoryInitDataEvent event,
//     Emitter<HistoryState> emit,
//   ) async {
//     final connectivityResult = await _connectivity.checkConnectivity();
//     if (connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.mobile) {
//       emit(
//         GetHistoryDataState(
//           status: BlocStatusState.loading,
//           viewModel: state.viewModel,
//         ),
//       );
//       try {
//         final responses = await bloodSugarUseCase.getListBloodSugarEntities(
//             patientId: event.id, endTime: event.endTime, startTime: event.startTime);

//         final newViewModel =
//             state.viewModel.copyWith(listBloodSugar: responses);
//         emit(
//           state.copyWith(
//             status: BlocStatusState.success,
//             viewModel: newViewModel,
//           ),
//         );
//       } catch (e) {
//         emit(
//           state.copyWith(
//             status: BlocStatusState.failure,
//             viewModel: state.viewModel,
//           ),
//         );
//       }
//     } else {
//       emit(
//         WifiDisconnectState(
//           status: BlocStatusState.success,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }
// /////

  Future<void> _onGetBloodSugarHistoryData(
    GetBloodSugarHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final responses = await bloodSugarUseCase.getListBloodSugarEntities(
            patientId: event.id,
            endTime: event.endTime,
            startTime: event.startTime);
        List<BloodSugarEntity>? listBloodSugar = [];
        for (var response in responses) {
          if (response.updatedDate!.isAfter(event.startTime) &&
              response.updatedDate!.isBefore(event.endTime)) {
            listBloodSugar.add(response);
          }
        }
        final newViewModel = state.viewModel.copyWith(
          listBloodSugar: listBloodSugar,
        );
        emit(
          state.copyWith(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel,
          ),
        );
      }
    } else {
      emit(
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }
//////

  // Future<void> _onGetTemperatureHistoryInitData(
  //   GetTemperatureHistoryInitDataEvent event,
  //   Emitter<HistoryState> emit,
  // ) async {
  //   final connectivityResult = await _connectivity.checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.wifi ||
  //       connectivityResult == ConnectivityResult.mobile) {
  //     emit(
  //       GetHistoryDataState(
  //         status: BlocStatusState.loading,
  //         viewModel: state.viewModel,
  //       ),
  //     );
  //     try {
  //       final responses = await temperatureUsecase.getListTemperatureEntities(
  //           patientId: event.id, endTime: event.endTime, startTime: event.startTime);

  //       final newViewModel =
  //           state.viewModel.copyWith(listTemperature: responses);
  //       emit(
  //         state.copyWith(
  //           status: BlocStatusState.success,
  //           viewModel: newViewModel,
  //         ),
  //       );
  //     } catch (e) {
  //       emit(
  //         state.copyWith(
  //           status: BlocStatusState.failure,
  //           viewModel: state.viewModel,
  //         ),
  //       );
  //     }
  //   } else {
  //     emit(
  //       WifiDisconnectState(
  //         status: BlocStatusState.success,
  //         viewModel: state.viewModel,
  //       ),
  //     );
  //   }
  // }

//////
  Future<void> _onGetTemperatureHistoryData(
    GetTemperatureHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final responses = await temperatureUsecase.getListTemperatureEntities(
            patientId: event.id,
            endTime: event.endTime,
            startTime: event.startTime);
        List<TemperatureEntity>? listTemperature = [];
        for (var response in responses) {
          if (response.updatedDate!.isAfter(event.startTime) &&
              response.updatedDate!.isBefore(event.endTime)) {
            listTemperature.add(response);
          }
        }
        final newViewModel =
            state.viewModel.copyWith(listTemperature: listTemperature);
        emit(
          state.copyWith(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel,
          ),
        );
      }
    } else {
      emit(
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  // Future<void> _onGetSpo2HistoryInitData(
  //   GetSpo2HistoryInitDataEvent event,
  //   Emitter<HistoryState> emit,
  // ) async {
  //   final connectivityResult = await _connectivity.checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.wifi ||
  //       connectivityResult == ConnectivityResult.mobile) {
  //     emit(
  //       GetHistoryDataState(
  //         status: BlocStatusState.loading,
  //         viewModel: state.viewModel,
  //       ),
  //     );
  //     try {
  //       final responses = await spo2Usecase.getListSpo2Entities(
  //           patientId: event.id, endTime: event.endTime, startTime: event.startTime);

  //       final newViewModel = state.viewModel.copyWith(listSpo2: responses);
  //       emit(
  //         state.copyWith(
  //           status: BlocStatusState.success,
  //           viewModel: newViewModel,
  //         ),
  //       );
  //     } catch (e) {
  //       emit(
  //         state.copyWith(
  //           status: BlocStatusState.failure,
  //           viewModel: state.viewModel,
  //         ),
  //       );
  //     }
  //   } else {
  //     emit(
  //       WifiDisconnectState(
  //         status: BlocStatusState.success,
  //         viewModel: state.viewModel,
  //       ),
  //     );
  //   }
  // }
/////

  Future<void> _onGetSpo2HistoryData(
    GetSpo2HistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final responses = await spo2Usecase.getListSpo2Entities(
            patientId: event.id,
            endTime: event.endTime,
            startTime: event.startTime);
        List<Spo2Entity>? listSpo2 = [];
        for (var response in responses) {
          if (response.updatedDate!.isAfter(event.startTime) &&
              response.updatedDate!.isBefore(event.endTime)) {
            listSpo2.add(response);
          }
        }
        final newViewModel = state.viewModel.copyWith(
          listSpo2: listSpo2,
        );
        emit(
          state.copyWith(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel,
          ),
        );
      }
    } else {
      emit(
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }
}

enum ReadDataTask { temperature, bloodPressure, bloodGlucose, spo2 }
