// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/user_detail_usecase.dart';
import '../../../common_widget/enum_common.dart';
import 'get_user_detail_event.dart';
import 'get_user_detail_state.dart';

@injectable
class GetUserDetailBloc extends Bloc<UserDetailEvent, GetUserDetailState> {
  final UserDetailUsecase _userUserDetailCase;

  GetUserDetailBloc(this._userUserDetailCase)
      : super(GetUserDetailLoadingState()) {
    on<GetUserDetailEvent>(_onGetUserDetail);
    on<DeleteUserEvent>(_onDeleteUser);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  Future<void> _onGetUserDetail(
    GetUserDetailEvent event,
    Emitter<GetUserDetailState> emit,
  ) async {
    emit(
      GetUserDetailLoadingState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );

    try {
      final response =
          await _userUserDetailCase.getUserDetailEntity(event.userId);
      final newViewModel = state.viewModel.copyWith(userDetailEntity: response);
      emit(GetUserDetailSuccessState(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ));
    } catch (e) {
      emit(
        GetUserDetailFailedState(
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
      GetUserDetailLoadingState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await _userUserDetailCase.deleteUserEntity(event.userId);
      emit(
        GetUserDetailSuccessState(
          status: BlocStatusState.success,
          viewModel: state.viewModel.copyWith(userDetailEntity: null),
        ),
      );
    } catch (e) {
      emit(
        GetUserDetailFailedState(
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
      GetUserDetailLoadingState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await _userUserDetailCase.updateUserEntity(event.userId, event.user);

      final newViewModel = state.viewModel
          .copyWith(userDetailEntity: state.viewModel.userDetailEntity);
      emit(GetUserDetailSuccessState(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ));
    } catch (e) {
      emit(
        GetUserDetailFailedState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }
}
