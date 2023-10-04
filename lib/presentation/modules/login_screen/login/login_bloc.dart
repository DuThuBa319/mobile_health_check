import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../../common/service/onesginal/onesignal_service.dart';
import '../../../../common/singletons.dart';
import '../../../../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';
import '../../../../domain/usecases/patient_usecase/patient_usecase.dart';
import '../../../common_widget/enum_common.dart';
import 'package:injectable/injectable.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PatientUsecase _patientUseCase;
  final Connectivity _connectivity;
  final NotificationUsecase count;
  LoginBloc(this._patientUseCase, this.count, this._connectivity)
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
        //! post => dữ liêu => lưu vào local
        // await userDataData.setUser(UserModel(
        //         email: userCredential.user?.email,
        //         role: documentSnapshot.get(FieldPath(const ['role'])),
        //         phoneNumber:
        //             documentSnapshot.get(FieldPath(const ['phoneNumber'])),
        //         id: documentSnapshot.get(FieldPath(const ['id'])),
        //         name: documentSnapshot.get(FieldPath(const ['name']))));

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
