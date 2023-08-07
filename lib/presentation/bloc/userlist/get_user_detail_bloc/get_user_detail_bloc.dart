// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/models/user_model.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/user_usecase/user_detail_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'get_user_detail_event.dart';
part 'get_user_detail_state.dart';

@injectable
class GetUserDetailBloc extends Bloc<UserDetailEvent, GetUserDetailState> {
  final UserDetailUsecase _userUserDetailCase;

  GetUserDetailBloc(this._userUserDetailCase)
      : super(GetUserDetailInitialState()) {
    on<GetUserDetailEvent>(_onGetUserDetail);
    on<DeleteUserEvent>(_onDeleteUser);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onGetUserDetail(
    GetUserDetailEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      GetDetailUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );

    try {
      final response =
          await _userUserDetailCase.getUserDetailEntity(event.userId);
      final newViewModel = state.viewModel.copyWith(userDetailEntity: response);
      emit(state.copyWith(
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

  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      DeleteUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await _userUserDetailCase.deleteUserEntity(event.userId);
      emit(
        DeleteUserState(
          status: BlocStatusState.success,
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

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      UpdateUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await _userUserDetailCase.updateUserEntity(event.userId, event.user);

      final newViewModel = state.viewModel
          .copyWith(userDetailEntity: state.viewModel.userDetailEntity);
      emit(state.copyWith(
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
}
