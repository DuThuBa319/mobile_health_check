import 'package:bloc/bloc.dart';
import 'package:common_project/domain/entities/blood_sugar_entity.dart';
import 'package:common_project/domain/entities/temperature_entity.dart';
import 'package:common_project/domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart';
import 'package:common_project/domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart';
import 'package:common_project/domain/usecases/temperature_usecase/temperature_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../common_widget/enum_common.dart';
part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final BloodPressureUsecase bloodPressureUseCase;
  final BloodSugarUsecase bloodSugarUseCase;
  final TemperatureUsecase temperatureUsecase;
 HistoryBloc(
    this.bloodPressureUseCase,
    this.bloodSugarUseCase,
        this.temperatureUsecase
  ) : super(HistoryInitialState()) {
    on<GetBloodPressureHistoryDataEvent>(_onGetBloodPressureHistoryData);
    on<GetBloodSugarHistoryDataEvent>(_onGetBloodSugarHistoryData);
    on<GetTemperatureHistoryDataEvent>(_onGetTemperatureHistoryData);
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
      final responses =
          await bloodPressureUseCase.getListBloodPressureEntities();
      List<BloodPressureEntity>? listBloodPressure = [];
      for (var response in responses) {
        if (response.updatedDate!.isAfter(event.startDate) &&
            response.updatedDate!.isBefore(event.endDate)) {
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
  }
  ///

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
      final responses = await bloodSugarUseCase.getListBloodSugarEntities();
      List<BloodSugarEntity>? listBloodSugar = [];
      for (var response in responses) {
        if (response.updatedDate!.isAfter(event.startDate) &&
            response.updatedDate!.isBefore(event.endDate)) {
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
      final responses = await temperatureUsecase.getListTemperatureEntities();
      List<TemperatureEntity>? listTemperature = [];
      for (var response in responses) {
        if (response.updatedDate!.isAfter(event.startDate) &&
            response.updatedDate!.isBefore(event.endDate)) {
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
