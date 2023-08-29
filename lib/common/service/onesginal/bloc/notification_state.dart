part of 'notification_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  // final List<BloodPressureEntity>? listBloodPressure;
  // final List<BloodSugarEntity>? listBloodSugar;
  // final List<TemperatureEntity>? listTemperature;
  final int? count;
  const _ViewModel(
      {
      // this.listBloodPressure,
      // this.listBloodSugar,
      // this.listTemperature,
      this.count});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({count}) {
    // ignore: unnecessary_this
    return _ViewModel(count: count);
  }
}

// Abstract class
abstract class NotificationState {
  final _ViewModel viewModel;
  // Status of the state. Notification "success" "failed" "loading"
  final BlocStatusState status;

  NotificationState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of NotificationState (abstract class)
  T copyWith<T extends NotificationState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == NotificationState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class NotificationInitialState extends NotificationState {
  NotificationInitialState({
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class UpdateNotificationState extends NotificationState {
  UpdateNotificationState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  NotificationInitialState: (viewModel, status) => NotificationInitialState(
        viewModel: viewModel,
        status: status,
      ),
  UpdateNotificationState: (viewModel, status) => UpdateNotificationState(
        viewModel: viewModel,
        status: status,
      ),
};
