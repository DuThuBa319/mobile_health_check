part of 'hourly_temperature_bloc.dart';

class _ViewModel {
  final List<HourlyTemperatureEntity>? hourlyTemperatureEntity;
  const _ViewModel({
    this.hourlyTemperatureEntity,
  });

  _ViewModel copyWith({
    List<HourlyTemperatureEntity>? hourlyTemperatureEntity,
  }) {
    return _ViewModel(
        hourlyTemperatureEntity:
            hourlyTemperatureEntity ?? this.hourlyTemperatureEntity);
  }
}

// Abstract class
abstract class HourlyTemperatureState {
  // ignore: library_private_types_in_public_api
  final _ViewModel viewModel;
  // Status of the state. HourlyTemperature "success" "failed" "loading"
  final BlocStatusState status;

  HourlyTemperatureState(this.viewModel,
      {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of HourlyTemperatureState (abstract class)
  T copyWith<T extends HourlyTemperatureState>({
    // ignore: library_private_types_in_public_api
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == HourlyTemperatureState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class HourlyTemperatureInitialState extends HourlyTemperatureState {
  HourlyTemperatureInitialState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class GetHourlyTemperatureState extends HourlyTemperatureState {
  GetHourlyTemperatureState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  HourlyTemperatureInitialState: (viewModel, status) =>
      HourlyTemperatureInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetHourlyTemperatureState: (viewModel, status) => GetHourlyTemperatureState(
        viewModel: viewModel,
        status: status,
      ),
};
