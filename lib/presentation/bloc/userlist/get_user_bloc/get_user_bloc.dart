import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common_project/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_event.dart';
import 'package:common_project/presentation/bloc/userlist/get_user_bloc/get_user_state.dart';

import '../../../../domain/usecases/user_usecase.dart';
import '../../../common_widget/dialog/show_toast.dart';
import '../../../common_widget/enum_common.dart';

@injectable
class GetUserBloc extends Bloc<UserEvent, GetUserState> {
  final UserUsecase _userUserCase;

  GetUserBloc(this._userUserCase) : super(GetUserLoadingState()) {
    on<GetUserEvent>(_onGetUser);
    on<FilterUserEvent>(_onSearchUser);
    on<RegistUserEvent>(_registUser);
  }

  Future<void> _onGetUser(
    GetUserEvent event,
    Emitter<GetUserState> emit,
  ) async {
    emit(
      GetUserLoadingState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await _userUserCase.getListUserEntity();
      final newViewModel = state.viewModel.copyWith(userEntity: response);
      emit(GetUserSuccessState(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onSearchUser(
    FilterUserEvent event,
    Emitter<GetUserState> emit,
  ) async {
    emit(
      GetUserLoadingState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final users = await _userUserCase.getListUserEntity();
      final filteredUsers = users
          ?.where((value) => value.name!
              .toLowerCase()
              .contains(event.searchText.toLowerCase()))
          .toList();
      final newViewModel = state.viewModel.copyWith(userEntity: filteredUsers);
      emit(GetUserSuccessState(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ));
    } catch (e) {
      emit(GetUserFailedState());
    }
  }

  Future<UserEntity> _registUser(
    RegistUserEvent event,
    Emitter<GetUserState> emit,
  ) async {
    try {
      emit(
        GetUserLoadingState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      final newUser = await _userUserCase.addUserEntity(event.user);
      final newViewModel = state.viewModel.copyWith(
        userEntity: state.viewModel.userEntity,
      );

      emit(
        GetUserSuccessState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ),
      );

      showToast('Người dùng đã được đăng ký thành công');
      return newUser;
    } catch (e) {
      emit(GetUserFailedState());
      rethrow;
    }
  }
}
