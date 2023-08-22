part of 'get_patient_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  // final List<BloodPressureEntity>? listBloodPressure;
  // final List<BloodSugarEntity>? listBloodSugar;
  // final List<TemperatureEntity>? listTemperature;
  final List<UserEntity>? userEntity;
  final PatientInforEntity? userDetailEntity;
  const _ViewModel({
    // this.listBloodPressure,
    // this.listBloodSugar,
    // this.listTemperature,
    this.userDetailEntity,
    this.userEntity,
  });

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    List<UserEntity>? userEntity,
    final PatientInforEntity? userDetailEntity,
  }) {
    // ignore: unnecessary_this
    return _ViewModel(
      userDetailEntity: userDetailEntity ?? this.userDetailEntity,
      userEntity: userEntity ?? this.userEntity,
      // listBloodPressure: listBloodPressure ?? listBloodPressure,
      // listBloodSugar: listBloodSugar ?? listBloodSugar,
      // listTemperature: listTemperature ?? listTemperature
    );
  }
}

// Abstract class
abstract class GetUserState {
  final _ViewModel viewModel;
  // Status of the state. GetUser "success" "failed" "loading"
  final BlocStatusState status;

  GetUserState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of GetUserState (abstract class)
  T copyWith<T extends GetUserState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == GetUserState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class GetUserInitialState extends GetUserState {
  GetUserInitialState({
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class GetListUserState extends GetUserState {
  GetListUserState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetUserDetailState extends GetUserState {
  GetUserDetailState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class RegistUserState extends GetUserState {
  RegistUserState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  GetUserInitialState: (viewModel, status) => GetUserInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetListUserState: (viewModel, status) => GetListUserState(
        viewModel: viewModel,
        status: status,
      ),
  RegistUserState: (viewModel, status) => RegistUserState(
        viewModel: viewModel,
        status: status,
      ),
  GetUserDetailState: (viewModel, status) => GetUserDetailState(
        viewModel: viewModel,
        status: status,
      ),
};
