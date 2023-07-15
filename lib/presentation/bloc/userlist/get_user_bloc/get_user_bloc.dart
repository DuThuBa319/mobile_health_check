import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common_project/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user_model.dart';
import '../../../../domain/usecases/user_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'get_user_event.dart';
part 'get_user_state.dart';

@injectable
class GetUserBloc extends Bloc<UserEvent, GetUserState> {
  final UserUsecase _userUserCase;

  GetUserBloc(this._userUserCase) : super(GetUserInitialState()) {
    on<GetListUserEvent>(_onGetUser);
    on<FilterUserEvent>(_onSearchUser);
    on<RegistUserEvent>(_registUser);
  }

  Future<void> _onGetUser(
    GetListUserEvent event,
    Emitter<GetUserState> emit,
  ) async {
    emit(
      GetListUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await _userUserCase.getListUserEntity();
      final newViewModel = state.viewModel.copyWith(userEntity: response);
      emit(GetListUserState(
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
      GetListUserState(
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
      emit(GetListUserState(
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

  Future<void> _registUser(
    RegistUserEvent event,
    Emitter<GetUserState> emit,
  ) async {
    emit(
      RegistUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final newUser = await _userUserCase.addUserEntity(event.user);

      final newViewModel = state.viewModel.copyWith(
        userEntity: state.viewModel.userEntity,
      );

      emit(
        RegistUserState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }
}
