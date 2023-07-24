import 'package:bloc/bloc.dart';
import 'package:common_project/domain/entities/hourly_temperature_entity.dart';
import 'package:common_project/domain/usecases/temperature_usecase/temperature_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../common_widget/enum_common.dart';

part 'hourly_temperature_event.dart';
part 'hourly_temperature_state.dart';

@injectable
class HourlyTemperatureBloc
extends Bloc<GetHourlyTemperatureEvent, HourlyTemperatureState> {
  final HourlyTemperatureUsecase _hourlyTemperatureUsecase;
  HourlyTemperatureBloc(this._hourlyTemperatureUsecase)
      : super(HourlyTemperatureInitialState()) {
    on<GetHourlyTemperatureEvent>(_onGetHourlyTemperature);
  }
  Future<void> _onGetHourlyTemperature(
    GetHourlyTemperatureEvent event,
    Emitter<HourlyTemperatureState> emit,
  ) async {
    emit(
      GetHourlyTemperatureState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await _hourlyTemperatureUsecase.getTemperatureEntity(
          endDate: event.endDate,
          latitude: event.latitude,
          longitude: event.longitude,
          startDate: event.startDate);
      final newViewModel =
          state.viewModel.copyWith(hourlyTemperatureEntity: response);
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
