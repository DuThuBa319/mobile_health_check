part of 'get_patient_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  // final List<BloodPressureEntity>? listBloodPressure;
  // final List<BloodSugarEntity>? listBloodSugar;
  // final List<TemperatureEntity>? listTemperature;

  final List<PatientInforEntity>? patientEntities;
  final PatientInforEntity? patientInforEntity;
  final DoctorInforEntity? doctorInforEntity;
  final RelativeInforEntity? relativeInforEntity;
  final List<RelativeInforEntity>? relativeEntities;
  final AccountEntity? accountEntity;

  const _ViewModel({
    // this.listBloodPressure,
    // this.listBloodSugar,
    // this.listTemperature,
    this.relativeInforEntity,
    this.accountEntity,
    this.relativeEntities,
    this.doctorInforEntity,
    this.patientInforEntity,
    this.patientEntities,
  });

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    final RelativeInforEntity? relativeInforEntity,
    final AccountEntity? accountEntity,
    final DoctorInforEntity? doctorInforEntity,
    final List<PatientInforEntity>? patientEntities,
    final PatientInforEntity? patientInforEntity,
    final List<RelativeInforEntity>? relativeEntities,
  }) {
    // ignore: unnecessary_this
    return _ViewModel(
      relativeInforEntity: relativeInforEntity ?? this.relativeInforEntity,
      accountEntity: accountEntity ?? this.accountEntity,
      relativeEntities: relativeEntities ?? this.relativeEntities,
      patientInforEntity: patientInforEntity ?? this.patientInforEntity,
      patientEntities: patientEntities ?? this.patientEntities,
      doctorInforEntity: doctorInforEntity ?? this.doctorInforEntity,
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

class WifiDisconnectState extends GetPatientState {
  WifiDisconnectState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}


class GetPatientListOfRelativeState extends GetPatientState {
  GetPatientListOfRelativeState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}



class SearchPatientState extends GetPatientState {
  SearchPatientState({
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



class RegistRelativeState extends GetPatientState {
  RegistRelativeState({
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


class UpdatePatientInforState extends GetPatientState {
  UpdatePatientInforState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}



class UpdateRelativeInforState extends GetPatientState {
  UpdateRelativeInforState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}


class DeleteRelativeState extends GetPatientState {
  DeleteRelativeState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}



class DeletePatientState extends GetPatientState {
  DeletePatientState({
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
 
  GetPatientListOfRelativeState: (viewModel, status) =>
      GetPatientListOfRelativeState(
        viewModel: viewModel,
        status: status,
      ),
 
  SearchPatientState: (viewModel, status) => SearchPatientState(
        viewModel: viewModel,
        status: status,
      ),
 
  RegistPatientState: (viewModel, status) => RegistPatientState(
        viewModel: viewModel,
        status: status,
      ),
  RegistRelativeState: (viewModel, status) => RegistRelativeState(
        viewModel: viewModel,
        status: status,
      ),
  GetPatientInforState: (viewModel, status) => GetPatientInforState(
        viewModel: viewModel,
        status: status,
      ),
  UpdatePatientInforState: (viewModel, status) => UpdatePatientInforState(
        viewModel: viewModel,
        status: status,
      ),
  UpdateRelativeInforState: (viewModel, status) => UpdateRelativeInforState(
        viewModel: viewModel,
        status: status,
      ),
  DeleteRelativeState: (viewModel, status) => DeleteRelativeState(
        viewModel: viewModel,
        status: status,
      ),
  DeletePatientState: (viewModel, status) => DeletePatientState(
        viewModel: viewModel,
        status: status,
      ),
  WifiDisconnectState: (viewModel, status) => WifiDisconnectState(
        viewModel: viewModel,
        status: status,
      ),
};
