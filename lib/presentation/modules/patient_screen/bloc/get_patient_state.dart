// ignore_for_file: library_private_types_in_public_api

part of 'get_patient_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  final List<PatientInforEntity>? patientEntities;
  final PatientInforEntity? patientInforEntity;
  final DoctorInforEntity? doctorInforEntity;
  final RelativeInforEntity? relativeInforEntity;
  final List<RelativeInforEntity>? relativeEntities;
  final bool? errorEmptyName;
  final bool? errorEmptyPhoneNumber;
  final bool? errorEmptyCurrentPassword;
  final bool? errorEmptyNewPassword;
  final bool? duplicatedRelationshipPAR;
  final bool? duplicatedRelationshipPAD;
  final bool? hasDoctorBefore;
  final bool? maximumRelativeCount;
  final bool? isWifiDisconnect;
  final int? unreadCount;
  final String? userName;
  final String? password;
  final String? errorMessage;

  const _ViewModel(
      { this.isWifiDisconnect,
        this.duplicatedRelationshipPAR,
      this.maximumRelativeCount,
      this.errorEmptyCurrentPassword,
      this.errorEmptyNewPassword,
      this.errorEmptyName,
      this.errorEmptyPhoneNumber,
      this.duplicatedRelationshipPAD,
      this.hasDoctorBefore,
      this.password,
      this.userName,
      this.unreadCount,
      this.relativeInforEntity,
      this.relativeEntities,
      this.doctorInforEntity,
      this.patientInforEntity,
      this.patientEntities,
      this.errorMessage});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith(
      {final bool? isWifiDisconnect,
        final bool? duplicatedRelationshipPAR,
      final bool? maximumRelativeCount,
      final bool? errorEmptyCurrentPassword,
      final bool? errorEmptyNewPassword,
      final bool? errorEmptyName,
      final bool? errorEmptyPhoneNumber,
      final bool? duplicatedRelationshipPAD,
      final bool? hasDoctorBefore,
      final List<PersonCellEntity>? allDoctorEntity,
      final RelativeInforEntity? relativeInforEntity,
      final DoctorInforEntity? doctorInforEntity,
      final List<PatientInforEntity>? patientEntities,
      final PatientInforEntity? patientInforEntity,
      final List<RelativeInforEntity>? relativeEntities,
      final int? unreadCount,
      final String? userName,
      final String? password,
      final String? errorMessage}) {
    // ignore: unnecessary_this
    return _ViewModel(
      isWifiDisconnect: isWifiDisconnect??this.isWifiDisconnect,
        duplicatedRelationshipPAR:
            duplicatedRelationshipPAR ?? this.duplicatedRelationshipPAR,
        maximumRelativeCount: maximumRelativeCount ?? this.maximumRelativeCount,
        duplicatedRelationshipPAD:
            duplicatedRelationshipPAD ?? this.duplicatedRelationshipPAD,
        hasDoctorBefore: hasDoctorBefore ?? this.hasDoctorBefore,
        unreadCount: unreadCount ?? this.unreadCount,
        relativeInforEntity: relativeInforEntity ?? this.relativeInforEntity,
        relativeEntities: relativeEntities ?? this.relativeEntities,
        patientInforEntity: patientInforEntity ?? this.patientInforEntity,
        patientEntities: patientEntities ?? this.patientEntities,
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
  }) : super(viewModel, status: status);
}

class GetPatientListState extends GetPatientState {
  GetPatientListState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetDoctorListState extends GetPatientState {
  GetDoctorListState({
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

class RemoveRelationshipRaPState extends GetPatientState {
  RemoveRelationshipRaPState({
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
  GetDoctorListState: (viewModel, status) => GetDoctorListState(
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
  RemoveRelationshipRaPState: (viewModel, status) => RemoveRelationshipRaPState(
        viewModel: viewModel,
        status: status,
      ),
  DeletePatientState: (viewModel, status) => DeletePatientState(
        viewModel: viewModel,
        status: status,
      ),
};
