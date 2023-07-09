import 'package:common_project/domain/entities/user_entity.dart';

import '../../../common_widget/enum_common.dart';

class _ViewModel {
  final List<UserEntity>? userEntity;

  const _ViewModel({
    this.userEntity,
  });

  _ViewModel copyWith({
    List<UserEntity>? userEntity,
  }) {
    return _ViewModel(
      userEntity: userEntity ?? this.userEntity,
    );
  }
}

abstract class GetUserState {
  final _ViewModel viewModel;
  final BlocStatusState status;

  GetUserState(this.viewModel, {this.status = BlocStatusState.loading});

  T copyWith<T extends GetUserState>({
    _ViewModel? viewModel,
    BlocStatusState? status,
  });
}

class GetUserLoadingState extends GetUserState {
  GetUserLoadingState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.loading,
  }) : super(viewModel, status: status);

  @override
  T copyWith<T extends GetUserState>({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return GetUserLoadingState(
      viewModel: viewModel ?? this.viewModel,
      status: status ?? this.status,
    ) as T;
  }
}

class GetUserSuccessState extends GetUserState {
  GetUserSuccessState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.success,
  }) : super(viewModel, status: status);

  @override
  T copyWith<T extends GetUserState>({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return GetUserSuccessState(
      viewModel: viewModel ?? this.viewModel,
      status: status ?? this.status,
    ) as T;
  }
}

class GetUserFailedState extends GetUserState {
  GetUserFailedState({
    _ViewModel viewModel = const _ViewModel(),
    BlocStatusState status = BlocStatusState.failure,
  }) : super(viewModel, status: status);

  @override
  T copyWith<T extends GetUserState>({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return GetUserFailedState(
      viewModel: viewModel ?? this.viewModel,
      status: status ?? this.status,
    ) as T;
  }
}

class RegisterState extends GetUserState {
  RegisterState(_ViewModel viewModel) : super(viewModel, status: BlocStatusState.loading);

  @override
  T copyWith<T extends GetUserState>({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return RegisterState(
      viewModel ?? this.viewModel,
    ) as T;
  }
}

final _factories = <Type, Function(_ViewModel viewModel, BlocStatusState status)>{
  GetUserLoadingState: (viewModel, status) => GetUserLoadingState(
        viewModel: viewModel,
        status: status,
      ),
  GetUserSuccessState: (viewModel, status) => GetUserSuccessState(
        viewModel: viewModel,
        status: status,
      ),
  GetUserFailedState: (viewModel, status) => GetUserFailedState(
        viewModel: viewModel,
        status: status,
      ),
};
