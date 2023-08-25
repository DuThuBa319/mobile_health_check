part of 'get_patient_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  // final List<BloodPressureEntity>? listBloodPressure;
  // final List<BloodSugarEntity>? listBloodSugar;
  // final List<TemperatureEntity>? listTemperature;
  final List<PatientEntity>? patientEntity;
  final PatientInforEntity? patientInforEntity;
  const _ViewModel({
    // this.listBloodPressure,
    // this.listBloodSugar,
    // this.listTemperature,
    this.patientInforEntity,
    this.patientEntity,
  });

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    List<PatientEntity>? patientEntity,
    final PatientInforEntity?   patientInforEntity,
  }) {
    // ignore: unnecessary_this
    return _ViewModel(
      patientInforEntity: patientInforEntity ?? this.patientInforEntity,
      patientEntity: patientEntity ?? this.patientEntity,
      // listBloodPressure: listBloodPressure ?? listBloodPressure,
      // listBloodSugar: listBloodSugar ?? listBloodSugar,
      // listTemperature: listTemperature ?? listTemperature
    );
  }
}

// Abstract class
abstract class GetPatientState {
  final _ViewModel viewModel;
  // Status of the state. GetPatient "success" "failed" "loading"
  final BlocStatusState status;

  GetPatientState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of GetPatientState (abstract class)
  T copyWith<T extends GetPatientState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == GetPatientState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class GetPatientInitialState extends GetPatientState {
  GetPatientInitialState({
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel);
}

class GetPatientListState extends GetPatientState {
  GetPatientListState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetPatientInforState extends GetPatientState {
  GetPatientInforState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class RegistPatientState extends GetPatientState {
  RegistPatientState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  GetPatientInitialState: (viewModel, status) => GetPatientInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetPatientListState: (viewModel, status) => GetPatientListState(
        viewModel: viewModel,
        status: status,
      ),
  RegistPatientState: (viewModel, status) => RegistPatientState(
        viewModel: viewModel,
        status: status,
      ),
  GetPatientInforState: (viewModel, status) => GetPatientInforState(
        viewModel: viewModel,
        status: status,
      ),
};
