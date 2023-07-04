part of 'daily_weather_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated
class _ViewModel {
  final List<DailyWeatherEntity>? dailyWeatherEntity;
  const _ViewModel({
    this.dailyWeatherEntity,
  });

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    List<DailyWeatherEntity>? dailyWeatherEntity,
  }) {
    return _ViewModel(
        dailyWeatherEntity: dailyWeatherEntity ?? this.dailyWeatherEntity);
  }
}

// Abstract class
abstract class DailyWeatherState {
  final _ViewModel viewModel;
  // Status of the state. DailyWeather "success" "failed" "loading"
  final BlocStatusState status;

  DailyWeatherState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of DailyWeatherState (abstract class)
  T copyWith<T extends DailyWeatherState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == DailyWeatherState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class DailyWeatherInitialState extends DailyWeatherState {
  DailyWeatherInitialState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel);
}

class GetDailyWeatherState extends DailyWeatherState {
  GetDailyWeatherState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  DailyWeatherInitialState: (viewModel, status) => DailyWeatherInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetDailyWeatherState: (viewModel, status) => GetDailyWeatherState(
        viewModel: viewModel,
        status: status,
      ),
};
