import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/classes/language.dart';

import 'package:mobile_health_check/domain/network/network_info.dart';
import 'package:mobile_health_check/domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../common/singletons.dart';
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
  final NetworkInfo networkInfo;

  HistoryBloc(
    this.bloodPressureUseCase,
    this.bloodSugarUseCase,
    this.networkInfo,
    this.temperatureUsecase,
    this.spo2Usecase,
  ) : super(HistoryInitialState()) {
    on<GetBloodPressureHistoryDataEvent>(_onGetBloodPressureHistoryData);
    on<GetBloodSugarHistoryDataEvent>(_onGetBloodSugarHistoryData);
    on<GetTemperatureHistoryDataEvent>(_onGetTemperatureHistoryData);
    on<GetSpo2HistoryDataEvent>(_onGetSpo2HistoryData);
  }

  ///
  Future<void> _onGetBloodPressureHistoryData(
    GetBloodPressureHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          GetHistoryDataState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          GetHistoryDataState(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
            isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onGetBloodSugarHistoryData(
    GetBloodSugarHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          GetHistoryDataState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          GetHistoryDataState(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
            isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onGetTemperatureHistoryData(
    GetTemperatureHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          GetHistoryDataState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          GetHistoryDataState(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
          isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onGetSpo2HistoryData(
    GetSpo2HistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          GetHistoryDataState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } catch (e) {
        emit(
          GetHistoryDataState(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        GetHistoryDataState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
          isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }
}

enum ReadDataTask { temperature, bloodPressure, bloodGlucose, spo2 }
