import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:mobile_health_check/classes/language.dart';
import 'package:mobile_health_check/data/models/authentication_model/authentication_model.dart';
import 'package:mobile_health_check/domain/network/network_info.dart';
import 'package:mobile_health_check/domain/usecases/reset_password_usecase/reset_password_usecase.dart';
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
  final ResetPasswordUsecase _resetPasswordUsecase;
  final NetworkInfo networkInfo;
  final NotificationUsecase count;

  LoginBloc(this._patientUseCase, this.count, this.networkInfo,
      this._authenUsecase, this._resetPasswordUsecase)
      : super(LoginInitialState()) {
    on<LoginUserEvent>(_onLogin);
    on<GetUserDataEvent>(_onGetUserData);
    on<ResetPasswordEvent>(_onResetPassword);
  }

//! RESET PASSWORD
  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        ResetPasswordState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      if (event.phoneNumber == null || event.phoneNumber?.trim() == '') {
        emit(
          ResetPasswordState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .pleaseEnterPhoneNumber,
            ),
          ),
        );
        return;
      }

      try {
        await _resetPasswordUsecase.resetPasswordEntity(
            phoneNumber: event.phoneNumber);
        emit(ResetPasswordState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ));
      } on DioException catch (e) {
        if (e.response?.data == "This phone number hasn't been registered") {
          emit(
            ResetPasswordState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .wrongPhoneNumber,
              ),
            ),
          );
          return;
        }
      } catch (e) {
        emit(
          ResetPasswordState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        ResetPasswordState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

//! Login
  Future<void> _onLogin(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        LoginActionState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      if (event.username == null || event.username == '') {
        emit(
          LoginActionState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              isLogin: false,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .pleaseEnterYourAccount,
            ),
          ),
        );
        return;
      }
      if (event.password == null || event.password?.trim() == '') {
        emit(
          LoginActionState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              isLogin: false,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .pleaseEnterYourAccount,
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
            role: response.role,
            phoneNumber: response.accountInfor?.phoneNumber,
            id: response.token?.id,
            name: response.accountInfor?.name));

        emit(
          LoginActionState(
            status: BlocStatusState.success,
            viewModel: const _ViewModel(
              isLogin: true,
              //  person: User(uuid: userCredential.user!.uid),
            ),
          ),
        );
      }
      //  e.requestOptions.queryParameters["errors"]
      //             ["Password"][0]
      //! catch do sai password
      on DioException catch (e) {
        if (e.response?.data == "Username or password is invalid") {
          emit(
            LoginActionState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                isLogin: false,
                isWrongAccount: true,
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .wrongAccount,
              ),
            ),
          );
        } else {
          emit(
            LoginActionState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                isLogin: false,
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error,
              ),
            ),
          );
        }
      } catch (e) {
        emit(
          LoginActionState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              isLogin: false,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error,
            ),
          ),
        );
      }
    } else {
      emit(
        LoginActionState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isLogin: false,
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

//! Get UserData
  Future<void> _onGetUserData(
    GetUserDataEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        GetUserDataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        if ((userDataData.getUser()?.role! == UserRole.doctor ||
            userDataData.getUser()?.role! == UserRole.relative)) {
          await OneSignalNotificationService.create();
          OneSignalNotificationService.subscribeNotification(
              userId: userDataData.getUser()!.id!);
        }
        if (userDataData.getUser()!.role! == UserRole.patient) {
          await _patientUseCase
              .getPatientInforEntityInPatientApp(userDataData.getUser()!.id!);
        }
        emit(
          GetUserDataState(
            status: BlocStatusState.success,
            viewModel: state.viewModel,
          ),
        );
      } catch (e) {
        emit(
          GetUserDataState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              isLogin: false,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error,
            ),
          ),
        );
      }
    } else {
      emit(
        GetUserDataState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }
}
