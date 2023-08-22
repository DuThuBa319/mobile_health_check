import 'package:bloc/bloc.dart';
import 'package:mobile_health_check/domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../../domain/entities/temperature_entity.dart';
import '../../../../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart';
import '../../../../domain/usecases/temperature_usecase/temperature_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final BloodPressureUsecase bloodPressureUseCase;
  final BloodSugarUsecase bloodSugarUseCase;
  final TemperatureUsecase temperatureUsecase;
  HistoryBloc(this.bloodPressureUseCase, this.bloodSugarUseCase,
      this.temperatureUsecase)
      : super(HistoryInitialState()) {
    on<GetBloodPressureHistoryDataEvent>(_onGetBloodPressureHistoryData);
    on<GetBloodSugarHistoryDataEvent>(_onGetBloodSugarHistoryData);
    on<GetTemperatureHistoryDataEvent>(_onGetTemperatureHistoryData);
    on<GetBloodPressureHistoryInitDataEvent>(
        _onGetBloodPressureHistoryInitData);
    on<GetBloodSugarHistoryInitDataEvent>(_onGetBloodSugarHistoryInitData);
    on<GetTemperatureHistoryInitDataEvent>(_onGetTemperatureHistoryInitData);
  }

  ///
  Future<void> _onGetBloodPressureHistoryData(
    GetBloodPressureHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      GetHistoryDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final responses = await bloodPressureUseCase.getListBloodPressureEntities(
          id: event.id, endTime: event.endTime, startTime: event.startTime);

      List<BloodPressureEntity>? listBloodPressure = [];
      for (var response in responses) {
        if (response.updatedDate!.isAfter(event.startTime) &&
            response.updatedDate!.isBefore(event.endTime)) {
          listBloodPressure.add(response);
          print(listBloodPressure);
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
  }

  ////
  Future<void> _onGetBloodPressureHistoryInitData(
    GetBloodPressureHistoryInitDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      GetHistoryDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final responses = await bloodPressureUseCase.getListBloodPressureEntities(
          id: event.id, endTime: event.endTime, startTime: event.startTime);
      List<BloodPressureEntity>? listBloodPressure = [];
      for (var response in responses) {
        listBloodPressure.add(response);
        print(listBloodPressure);
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
  }

  ///

  Future<void> _onGetBloodSugarHistoryInitData(
    GetBloodSugarHistoryInitDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      GetHistoryDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final responses = await bloodSugarUseCase.getListBloodSugarEntities(
          id: event.id, endTime: event.endTime, startTime: event.startTime);

      final newViewModel = state.viewModel.copyWith(listBloodSugar: responses);
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
  }
/////

  Future<void> _onGetBloodSugarHistoryData(
    GetBloodSugarHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      GetHistoryDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final responses = await bloodSugarUseCase.getListBloodSugarEntities(
          id: event.id, endTime: event.endTime, startTime: event.startTime);
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
  }
//////

  Future<void> _onGetTemperatureHistoryInitData(
    GetTemperatureHistoryInitDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      GetHistoryDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final responses = await temperatureUsecase.getListTemperatureEntities(
          id: event.id, endTime: event.endTime, startTime: event.startTime);

      final newViewModel = state.viewModel.copyWith(listTemperature: responses);
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
  }

//////
  Future<void> _onGetTemperatureHistoryData(
    GetTemperatureHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      GetHistoryDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final responses = await temperatureUsecase.getListTemperatureEntities(
          id: event.id, endTime: event.endTime, startTime: event.startTime);
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
  }
}

enum ReadDataTask { temperature, bloodPressure, bloodGlucose }
