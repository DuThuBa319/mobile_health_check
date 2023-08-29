part of 'login_bloc.dart';

class User {
  String? uuid;

  User({
    this.uuid,
  });
}

// ViewModel is used for store all properties which want to be stored, processed and updated
class _ViewModel {
  final bool isLogin;
  final String? errorMessage;
  final User? person;

  const _ViewModel({this.isLogin = false, this.errorMessage, this.person});

  // Using copyWith function to retains the before data and just "update some specific props" instead of "update all props"
  _ViewModel copyWith({
    bool? isLogin,
    String? errorMessage,
    User? person,
  }) {
    return _ViewModel(
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

class LoginInitialState extends LoginState {
  LoginInitialState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel);
}

class LoginSuccessState extends LoginState {
  LoginSuccessState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.initial,
  }) : super(viewModel, status: status);
}

class LoginFailState extends LoginState {
  LoginFailState({
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
  LoginSuccessState: (viewModel, status) => LoginSuccessState(
        viewModel: viewModel,
        status: status,
      ),
  LoginFailState: (viewModel, status) => LoginFailState(
        viewModel: viewModel,
        status: status,
      ),
};