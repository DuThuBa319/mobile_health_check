part of 'notification_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and Getd, chứa dữ liệu của 1 state
class _ViewModel {
  // final List<BloodPressureEntity>? listBloodPressure;
  // final List<BloodSugarEntity>? listBloodSugar;
  // final List<TemperatureEntity>? listTemperature;
  final List<NotificationEntity>? notificationEntity;

  const _ViewModel({this.notificationEntity
      // this.listBloodPressure,
      // this.listBloodSugar,
      // this.listTemperature,
      });

  // Using copyWith function to retains the before data and just "Get some specific props" instead of "Get all props"
  _ViewModel copyWith(
      {List<NotificationEntity>? notificationEntity,
    }) {
    // ignore: unnecessary_this
    return _ViewModel(
        notificationEntity: notificationEntity ?? this.notificationEntity,
      );
  }
}

// Abstract class
abstract class NotificationState {
  final _ViewModel viewModel;
  // Status of the state. Notification "success" "failed" "loading"
  final BlocStatusState status;

  NotificationState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "Get some specific props" instead of "Get all props"
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

class GetNotificationListState extends NotificationState {
  GetNotificationListState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class SetReadedNotificationState extends NotificationState {
  SetReadedNotificationState({
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
  GetNotificationListState: (viewModel, status) => GetNotificationListState(
        viewModel: viewModel,
        status: status,
      ),
  SetReadedNotificationState: (viewModel, status) => SetReadedNotificationState(
        viewModel: viewModel,
        status: status,
      ),
};
