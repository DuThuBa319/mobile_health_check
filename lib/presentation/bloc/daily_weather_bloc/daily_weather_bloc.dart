import 'package:bloc/bloc.dart';
import 'package:common_project/domain/usecases/example_usecase/example_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/daily_weather_entity.dart';
import '../../common_widget/enum_common.dart';

part 'daily_weather_event.dart';
part 'daily_weather_state.dart';

@injectable
class DailyWeatherBloc extends Bloc<DailyWeatherEvent, DailyWeatherState> {
  final ExampleUsecase _exampleUsecase;
  DailyWeatherBloc(this._exampleUsecase) : super(DailyWeatherInitialState()) {
    on<GetDailyWeatherEvent>(_onGetDailyWeather);
  }
  Future<void> _onGetDailyWeather(
    GetDailyWeatherEvent event,
    Emitter<DailyWeatherState> emit,
  ) async {
    emit(
      GetDailyWeatherState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await _exampleUsecase.getWeatherEntity(
          endDate: event.endDate,
          latitude: event.latitude,
          longtitude: event.longtitude,
          startDate: event.startDate);
      final newViewModel =
          state.viewModel.copyWith(dailyWeatherEntity: response);
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
