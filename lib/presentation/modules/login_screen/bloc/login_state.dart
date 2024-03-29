part of 'login_bloc.dart';

class User {
  String? uuid;
  SignInEntity? signInEntity;
  User({this.uuid, this.signInEntity});
}

// ViewModel is used for store all properties which want to be stored, processed and updated
class _ViewModel {
  final SignInEntity? signInEntity;
  final int? count;
  final bool isLogin;
  final String? errorMessage;
  final bool? isWifiDisconnect;
  final bool? isWrongAccount;

  final User? person;

  // final PatientInforEntity? patientInforEntity;

  const _ViewModel({
    this.isWrongAccount,
    this.isWifiDisconnect,
    this.signInEntity,
    this.count,
    this.isLogin = false,
    this.errorMessage,
    this.person,
    // this.patientInforEntity
  });

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    bool? isWrongAccount,
    bool? isWifiDisconnect,
    SignInEntity? signInEntity,
    int? count,
    bool? isLogin,
    String? errorMessage,
    User? person,
    // PatientInforEntity? patientInforEntity
  }) {
    return _ViewModel(
      isWrongAccount: isWrongAccount ?? this.isWrongAccount,
      isWifiDisconnect: isWifiDisconnect ?? this.isWifiDisconnect,
      // patientInforEntity: patientInforEntity?? this.patientInforEntity,
      signInEntity: signInEntity ?? this.signInEntity,
      count: count ?? this.count,
      isLogin: isLogin ?? this.isLogin,
      errorMessage: errorMessage ?? this.errorMessage,
      person: person ?? this.person,
    );
  }
}

// Abstract class
abstract class LoginState {
  final _ViewModel viewModel;
  // Status of the state. Login "success" "failed" "loading"
  final BlocStatusState status;

  LoginState(this.viewModel, {this.status = BlocStatusState.initial});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  // "T" is generic class. "T" is a child class of LoginState (abstract class)
  T copyWith<T extends LoginState>({
    _ViewModel? viewModel,
    required BlocStatusState status,
  }) {
    return _factories[T == LoginState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
      status,
    );
  }
}

// class GetPatientInforInPatientAppState extends LoginState {
//   GetPatientInforInPatientAppState({
//     _ViewModel viewModel = const _ViewModel(),
//     BlocStatusState status = BlocStatusState.initial,
//   }) : super(viewModel, status: status);
// }

class ResetPasswordState extends LoginState {
  ResetPasswordState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class LoginInitialState extends LoginState {
  LoginInitialState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel);
}

class LoginActionState extends LoginState {
  LoginActionState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class GetUserDataState extends LoginState {
  GetUserDataState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

final _factories = <Type,
    Function(
  _ViewModel viewModel,
  BlocStatusState status,
)>{
  LoginInitialState: (viewModel, status) => LoginInitialState(
        viewModel: viewModel,
        status: status,
      ),
  LoginActionState: (viewModel, status) => LoginActionState(
        viewModel: viewModel,
        status: status,
      ),
  GetUserDataState: (viewModel, status) => GetUserDataState(
        viewModel: viewModel,
        status: status,
      ),
  ResetPasswordState: (viewModel, status) => ResetPasswordState(
        viewModel: viewModel,
        status: status,
      ),
};
