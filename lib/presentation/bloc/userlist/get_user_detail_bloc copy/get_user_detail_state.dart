import 'package:common_project/domain/entities/user_entity.dart';
import '../../../common_widget/enum_common.dart';
import '../get_user_bloc/get_user_state.dart';

class _ViewModel {
  final UserEntity userDetailEntity;

  _ViewModel(this.userDetailEntity);

  _ViewModel copyWith({
    UserEntity? userDetailEntity,
  }) {
    return _ViewModel(userDetailEntity ?? this.userDetailEntity);
  }
}

abstract class GetUserDetailState<T extends GetUserDetailState<T>> {
  final _ViewModel viewModel;
  final BlocStatusState status;

  GetUserDetailState(this.viewModel, {this.status = BlocStatusState.loading});

  T copyWith({
    _ViewModel? viewModel,
    BlocStatusState? status,
  });
}

class DeleteUserState extends GetUserDetailState<DeleteUserState> {
  DeleteUserState({
    _ViewModel? viewModel,
    BlocStatusState status = BlocStatusState.loading,
  }) : super(viewModel ?? _ViewModel(UserEntity()), status: status);

  @override
  DeleteUserState copyWith({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return DeleteUserState(
      viewModel: viewModel ?? this.viewModel,
      status: status ?? this.status,
    );
  }
}

class UpdateUserState extends GetUserDetailState<UpdateUserState> {
  UpdateUserState(_ViewModel viewModel)
      : super(viewModel, status: BlocStatusState.loading);

  @override
  UpdateUserState copyWith({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return UpdateUserState(
      viewModel ?? this.viewModel,
    );
  }
}


class GetUserDetailLoadingState extends GetUserDetailState<GetUserDetailLoadingState> {
  GetUserDetailLoadingState({
    _ViewModel? viewModel,
    BlocStatusState status = BlocStatusState.loading,
  }) : super(viewModel ?? _ViewModel(UserEntity()), status: status);

  @override
  GetUserDetailLoadingState copyWith({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return GetUserDetailLoadingState(
      viewModel: viewModel ?? this.viewModel,
      status: status ?? this.status,
    );
  }
}

class GetUserDetailSuccessState extends GetUserDetailState<GetUserDetailSuccessState> {
  GetUserDetailSuccessState({
    _ViewModel? viewModel,
    BlocStatusState status = BlocStatusState.success,
  }) : super(viewModel ?? _ViewModel(UserEntity()), status: status);

  @override
  GetUserDetailSuccessState copyWith({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return GetUserDetailSuccessState(
      viewModel: viewModel ?? this.viewModel,
      status: status ?? this.status,
    );
  }
}

class GetUserDetailFailedState extends GetUserDetailState<GetUserDetailFailedState> {
  GetUserDetailFailedState({
    _ViewModel? viewModel,
    BlocStatusState status = BlocStatusState.failure,
  }) : super(viewModel ?? _ViewModel(UserEntity()), status: status);

  @override
  GetUserDetailFailedState copyWith({
    _ViewModel? viewModel,
    BlocStatusState? status,
  }) {
    return GetUserDetailFailedState(
      viewModel: viewModel ?? this.viewModel,
      status: status ?? this.status,
    );
  }
}

final _factories = <Type, Function(_ViewModel viewModel, BlocStatusState status)>{
  GetUserDetailLoadingState: (viewModel, status) => GetUserDetailLoadingState(
        viewModel: viewModel,
        status: status,
      ),
  GetUserDetailSuccessState: (viewModel, status) => GetUserDetailSuccessState(
        viewModel: viewModel,
        status: status,
      ),
  GetUserDetailFailedState: (viewModel, status) => GetUserDetailFailedState(
        viewModel: viewModel,
        status: status,
      ),
};
