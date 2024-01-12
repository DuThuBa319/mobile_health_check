part of 'admin_bloc.dart';

// ViewModel is used for store all properties which want to be stored, processed and updated, chứa dữ liệu của 1 state
class _ViewModel {
  final bool? duplicatedDoctorPhoneNumber;
  final AdminInforEntity? adminInforEntity;
  final DoctorInforEntity? doctorInforEntity;
  final bool? errorEmptyName;
  final bool? errorEmptyPhoneNumber;
  final bool? isWifiDisconnect;
  final List<PersonCellEntity>? allDoctorEntity;
  final String? errorMessage;
  const _ViewModel({
    this.isWifiDisconnect,
    this.duplicatedDoctorPhoneNumber,
    this.errorEmptyName,
    this.errorMessage,
    this.allDoctorEntity,
    this.errorEmptyPhoneNumber,
    this.doctorInforEntity,
    this.adminInforEntity,
  });

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith(
      {final bool? isWifiDisconnect,
        final bool? duplicatedDoctorPhoneNumber,
      final String? errorMessage,
      final List<PersonCellEntity>? allDoctorEntity,
      final DoctorInforEntity? doctorInforEntity,
      final bool? errorEmptyName,
      final bool? errorEmptyPhoneNumber,
      final AdminInforEntity? adminInforEntity}) {
    // ignore: unnecessary_this
    return _ViewModel(
      isWifiDisconnect: isWifiDisconnect?? this.isWifiDisconnect,
        duplicatedDoctorPhoneNumber:
            duplicatedDoctorPhoneNumber ?? this.duplicatedDoctorPhoneNumber,
        adminInforEntity: adminInforEntity ?? this.adminInforEntity,
        errorMessage: errorMessage ?? this.errorMessage,
        allDoctorEntity: allDoctorEntity ?? this.allDoctorEntity,
        doctorInforEntity: doctorInforEntity ?? this.doctorInforEntity,
        errorEmptyName: errorEmptyName ?? this.errorEmptyName,
        errorEmptyPhoneNumber:
            errorEmptyPhoneNumber ?? this.errorEmptyPhoneNumber);
  }
}

// Abstract class
abstract class GetDoctorState {
  // ignore: library_private_types_in_public_api
  final _ViewModel viewModel;
  // Status of the state. GetDoctor "success" "failed" "loading"
  final BlocStatusState status;

  // ignore: library_private_types_in_public_api
  GetDoctorState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of GetDoctorState (abstract class)
  T copyWith<T extends GetDoctorState>({
    // ignore: library_private_types_in_public_api
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == GetDoctorState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

class GetDoctorInitialState extends GetDoctorState {
  GetDoctorInitialState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetDoctorListState extends GetDoctorState {
  GetDoctorListState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class SearchDoctorState extends GetDoctorState {
  SearchDoctorState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetDoctorInforState extends GetDoctorState {
  GetDoctorInforState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class DeleteDoctorState extends GetDoctorState {
  DeleteDoctorState({
    // ignore: library_private_types_in_public_api
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class RegistDoctorState extends GetDoctorState {
  RegistDoctorState({
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
  GetDoctorInitialState: (viewModel, status) => GetDoctorInitialState(
        viewModel: viewModel,
        status: status,
      ),
  GetDoctorListState: (viewModel, status) => GetDoctorListState(
        viewModel: viewModel,
        status: status,
      ),
  SearchDoctorState: (viewModel, status) => SearchDoctorState(
        viewModel: viewModel,
        status: status,
      ),
  GetDoctorInforState: (viewModel, status) => GetDoctorInforState(
        viewModel: viewModel,
        status: status,
      ),
  DeleteDoctorState: (viewModel, status) => DeleteDoctorState(
        viewModel: viewModel,
        status: status,
      ),
  RegistDoctorState: (viewModel, status) => RegistDoctorState(
        viewModel: viewModel,
        status: status,
      ),
};
