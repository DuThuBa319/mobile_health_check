// ignore_for_file: library_private_types_in_public_api

part of 'setting_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  // final List<BloodPressureEntity>? listBloodPressure;
  // final List<BloodSugarEntity>? listBloodSugar;
  // final List<TemperatureEntity>? listTemperature;

  final PatientInforEntity? patientInforEntity;
  final DoctorInforEntity? doctorInforEntity;
  final RelativeInforEntity? relativeInforEntity;
  final List<RelativeInforEntity>? relativeEntities;
  final String? errorEmptyName;
  final String? errorEmptyPhoneNumber;
  final String? errorEmptyCurrentPassword;
  final String? errorEmptyNewPassword;
  final String? userName;
  final String? password;
  final String? errorMessage;

  const _ViewModel(
      {this.errorEmptyCurrentPassword,
      this.errorEmptyNewPassword,
      this.errorEmptyName,
      this.errorEmptyPhoneNumber,
      this.password,
      this.userName,
      this.relativeInforEntity,
      this.relativeEntities,
      this.doctorInforEntity,
      this.patientInforEntity,
      this.errorMessage});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith(
      {final String? errorEmptyCurrentPassword,
      final String? errorEmptyNewPassword,
      final String? errorEmptyName,
      final String? errorEmptyPhoneNumber,
      final RelativeInforEntity? relativeInforEntity,
      final DoctorInforEntity? doctorInforEntity,
      final List<PatientInforEntity>? patientEntities,
      final PatientInforEntity? patientInforEntity,
      final List<RelativeInforEntity>? relativeEntities,
      final String? userName,
      final String? password,
      final String? errorMessage}) {
    // ignore: unnecessary_this
    return _ViewModel(
        relativeInforEntity: relativeInforEntity ?? this.relativeInforEntity,
        relativeEntities: relativeEntities ?? this.relativeEntities,
        patientInforEntity: patientInforEntity ?? this.patientInforEntity,
        doctorInforEntity: doctorInforEntity ?? this.doctorInforEntity,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
        errorEmptyPhoneNumber:
            errorEmptyPhoneNumber ?? this.errorEmptyPhoneNumber,
        errorEmptyName: errorEmptyName ?? this.errorEmptyName,
        errorEmptyCurrentPassword:
            errorEmptyCurrentPassword ?? this.errorEmptyCurrentPassword,
        errorEmptyNewPassword:
            errorEmptyNewPassword ?? this.errorEmptyNewPassword);
  }
}

// Abstract class
abstract class SettingState {
  final _ViewModel viewModel;
  // Status of the state. Setting "success" "failed" "loading"
  final BlocStatusState status;

  SettingState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of SettingState (abstract class)
  T copyWith<T extends SettingState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == SettingState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}


class SettingInitialState extends SettingState {
 SettingInitialState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class UpdatePatientInforState extends SettingState {
  UpdatePatientInforState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class UpdateRelativeInforState extends SettingState {
  UpdateRelativeInforState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class UpdateDoctorInforState extends SettingState {
  UpdateDoctorInforState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class ChangePassState extends SettingState {
  ChangePassState({
    _ViewModel viewModel =
        const _ViewModel(), //ViewModel là dữ liệu trong state
    BlocStatusState status = BlocStatusState.initial, //status của state
  }) : super(viewModel, status: status);
}







final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
 
  // SettingListOfRelativeState: (viewModel, status) =>
  //     SettingListOfRelativeState(
  //       viewModel: viewModel,
  //       status: status,
  //     ),
 SettingInitialState: (viewModel, status) => SettingInitialState(
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
  UpdateDoctorInforState: (viewModel, status) => UpdateDoctorInforState(
        viewModel: viewModel,
        status: status,
      ),
       ChangePassState: (viewModel, status) => ChangePassState(
        viewModel: viewModel,
        status: status,
      ),

};
