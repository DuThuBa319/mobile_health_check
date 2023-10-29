import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/classes/language.dart';
import 'package:mobile_health_check/common/service/navigation/navigation_service.dart';
import 'package:mobile_health_check/data/models/authentication_model/authentication_model.dart';

import '../../../../common/service/local_manager/user_data_datasource/user_model.dart';
import '../../../../common/service/onesginal/onesignal_service.dart';
import '../../../../common/singletons.dart';
import '../../../../di/di.dart';
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
    NavigationService navigationService = injector<NavigationService>();
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        LoginActionState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      if (event.username == null ||
          event.username?.trim() == '' ||
          event.password == null ||
          event.password?.trim() == '') {
        if (event.username == null || event.username?.trim() == '') {
          emit(
            LoginActionState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                isLogin: false,
                errorMessage1:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourAccount,
              ),
            ),
          );
        }
        if (event.password == null || event.password?.trim() == '') {
          emit(
            LoginActionState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                isLogin: false,
                errorMessage2:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourPassword,
              ),
            ),
          );
        }
        if ((event.password == null || event.password?.trim() == '') &&
            (event.username == null || event.username?.trim() == '')) {
          emit(
            LoginActionState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                isLogin: false,
                errorMessage2:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourPassword,
                errorMessage1:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourAccount,
              ),
            ),
          );
        }

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
            viewModel: state.viewModel.copyWith(
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
                errorMessage1:
                    translation(navigationService.navigatorKey.currentContext!)
                        .wrongAccount,
              ),
            ),
          );
          return;
        }
       
      } catch (e) {
        emit(
          LoginActionState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              isLogin: false,
              errorMessage1:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error,
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
    NavigationService navigationService = injector<NavigationService>();

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
        // if (userDataData.getUser()!.role! == "doctor" &&
        //     userDataData.getUser()!.id ==
        //         "97488bbf-6737-4476-9bcc-4644efe6bf70") {}

        if ((userDataData.getUser()!.role! == UserRole.doctor ||
            userDataData.getUser()!.role! == UserRole.relative)) {
          await OneSignalNotificationService.create();
          OneSignalNotificationService.subscribeNotification(
              userId: userDataData.getUser()!.id!);
        }
        if (userDataData.getUser()!.role! == UserRole.patient) {
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
            viewModel: _ViewModel(
              isLogin: false,
              errorMessage1:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error,
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
