part of 'history_bloc.dart';

class _ViewModel {
  final List<BloodPressureEntity>? listBloodPressure;
  final List<BloodSugarEntity>? listBloodSugar;
  final List<TemperatureEntity>? listTemperature;
  const _ViewModel(
      {this.listTemperature, this.listBloodSugar, this.listBloodPressure});

  _ViewModel copyWith(
      {List<BloodPressureEntity>? listBloodPressure,
      List<BloodSugarEntity>? listBloodSugar,
      List<TemperatureEntity>? listTemperature}) {
    return _ViewModel(
      listTemperature: listTemperature ?? this.listTemperature,
      listBloodSugar: listBloodSugar ?? this.listBloodSugar,
      listBloodPressure: listBloodPressure ?? this.listBloodPressure,
    );
  }
}

// Abstract class
abstract class HistoryState {
  // ignore: library_private_types_in_public_api
  final _ViewModel viewModel;
  // Status of the state. History "success" "failed" "loading"
  final BlocStatusState status;

  HistoryState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of HistoryState (abstract class)
  T copyWith<T extends HistoryState>({
    // ignore: library_private_types_in_public_api
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == HistoryState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class HistoryInitialState extends HistoryState {
  HistoryInitialState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class GetHistoryDataState extends HistoryState {
  GetHistoryDataState({
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
  HistoryInitialState: (viewModel, status) => HistoryInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetHistoryDataState: (viewModel, status) => GetHistoryDataState(
        viewModel: viewModel,
        status: status,
      ),
};
