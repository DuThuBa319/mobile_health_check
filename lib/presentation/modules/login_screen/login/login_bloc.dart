import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/data/models/authentication_model/authentication_model.dart';

import '../../../../common/service/local_manager/user_data_datasource/user_model.dart';
import '../../../../common/service/onesginal/onesignal_service.dart';
import '../../../../common/singletons.dart';
import '../../../../domain/entities/login_entity_group/authentication_entity.dart';
import '../../../../domain/entities/login_entity_group/sign_in_entity.dart';
import '../../../../domain/usecases/authentication_usecase/authentication_usecase.dart';
import '../../../../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';
import '../../../../domain/usecases/patient_usecase/patient_usecase.dart';
import '../../../common_widget/enum_common.dart';
import 'package:injectable/injectable.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PatientUsecase _patientUseCase;
  final AuthenUsecase _authenUsecase;

  final Connectivity _connectivity;
  final NotificationUsecase count;
  LoginBloc(
      this._patientUseCase, this.count, this._connectivity, this._authenUsecase)
      : super(LoginInitialState()) {
    on<LoginUserEvent>(_onLogin);
    on<GetUserDataEvent>(_onGetUserData);
  }

  Future<void> _onLogin(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        LoginActionState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      // final response = await _usecase.getListUserEntity();
      if (event.username == null || event.username?.trim() == '') {
        emit(
          LoginActionState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isLogin: false,
              errorMessage: 'Vui lòng nhập tài khoản',
            ),
          ),
        );
        return;
      }
      if (event.password == null || event.password?.trim() == '') {
        emit(
          LoginActionState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isLogin: false,
              errorMessage: 'Vui lòng nhập mật khẩu',
            ),
          ),
        );
        return;
      }
      try {
        final AuthenEntity authenInforEntity =
            AuthenModel(username: event.username, password: event.password)
                .converToAuthenInforEntity();
        final response =
            await _authenUsecase.signInAuthenEntity(authenInforEntity);
        //! post => dữ liêu => lưu vào local
        await userDataData.setUser(UserModel(
            role: (response.roles?[0] == "Doctor")
                ? "doctor"
                : (response.roles?[0] == "Relative")
                    ? "relative"
                    : "patient",
            phoneNumber: response.accountInfor?.phoneNumber,
            id: response.token?.id,
            name: response.accountInfor?.name));
        emit(
          LoginActionState(
            status: BlocStatusState.success,
            viewModel: state.viewModel.copyWith(
              isLogin: true,
              //  person: User(uuid: userCredential.user!.uid),
            ),
          ),
        );
      }
      //! catch do sai password
      catch (e) {
        emit(
          LoginActionState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isLogin: false,
              errorMessage: 'Xảy ra lỗi',
            ),
          ),
        );
      }
    } else {
      emit(
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onGetUserData(
    GetUserDataEvent event,
    Emitter<LoginState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetUserDataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        if (userDataData.getUser()!.role! == 'doctor' ||
            userDataData.getUser()!.role! == 'relative') {
          await OneSignalNotificationService.create();
          OneSignalNotificationService.subscribeNotification(
              userId: userDataData.getUser()!.id!);
        }
        if (userDataData.getUser()!.role! == 'patient') {
          await _patientUseCase
              .getPatientInforEntityInPatientApp(userDataData.getUser()!.id!);
        }
        emit(
          state.copyWith(
            status: BlocStatusState.success,
            viewModel: state.viewModel,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isLogin: false,
              errorMessage: 'Xảy ra lỗi',
            ),
          ),
        );
      }
    } else {
      emit(
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }
}
