import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/service/navigation/navigation_service.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/domain/usecases/change_pass_usecase/change_pass_usecase.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';

import '../../../../classes/language.dart';
import '../../../../di/di.dart';
import '../../../../domain/entities/change_password_entity.dart';
import '../../../../domain/entities/relative_infor_entity.dart';
import '../../../../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';
import '../../../../domain/usecases/patient_usecase/patient_usecase.dart';
import '../../../../domain/usecases/relative_infor_usecase/relative_infor_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'setting_event.dart';
part 'setting_state.dart';

@injectable
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final PatientUsecase _patientUseCase;
  final DoctorInforUsecase _doctorInforUsecase;
  final RelativeInforUsecase _relativeInforUsecase;
  final NotificationUsecase notificationUsecase;
  final ChangePassUsecase changePassUsecase;
  final Connectivity _connectivity;
  SettingBloc(
      this._patientUseCase,
      this._doctorInforUsecase,
      this._relativeInforUsecase,
      this._connectivity,
      this.notificationUsecase,
      this.changePassUsecase)
      : super(SettingInitialState()) {
    on<UpdatePatientInforEvent>(_onUpdatePatientInfor);
    on<UpdateRelativeInforEvent>(_onUpdateRelativeInfor);
    on<UpdateDoctorInforEvent>(_onUpdateDoctorInfor);
    on<ChangePassEvent>(_onChangePass);
  }

  //! CHANGE PASSWORD

  Future<void> _onChangePass(
    ChangePassEvent event,
    Emitter<SettingState> emit,
  ) async {
    NavigationService navigationService = injector<NavigationService>();

    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      if (event.changePassEntity.currentPassword == null ||
          event.changePassEntity.currentPassword?.trim() == '' ||
          event.changePassEntity.newPassword == null ||
          event.changePassEntity.newPassword?.trim() == '') {
        if (event.changePassEntity.currentPassword == null ||
            event.changePassEntity.currentPassword?.trim() == '') {
          emit(
            state.copyWith(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyCurrentPassword:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourCurrentPassword,
              ),
            ),
          );
        }
        if (event.changePassEntity.newPassword == null ||
            event.changePassEntity.newPassword?.trim() == '') {
          emit(
            state.copyWith(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyNewPassword:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourNewPassword,
              ),
            ),
          );
        }
        if ((event.changePassEntity.newPassword == null ||
                event.changePassEntity.newPassword?.trim() == '') &&
            (event.changePassEntity.currentPassword == null ||
                event.changePassEntity.currentPassword?.trim() == '')) {
          emit(
            state.copyWith(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyCurrentPassword:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourCurrentPassword,
                errorEmptyNewPassword:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterYourNewPassword,
              ),
            ),
          );
        }
        return;
      }
      
      emit(
        ChangePassState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await changePassUsecase.changePassEntity(
            event.changePassEntity, event.userId);
        final newViewModel = state.viewModel;
        emit(state.copyWith(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ));
      } on DioException catch (e) {
        if (e.response?.data == "Password is invalid") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .currentPassWrong),
          ));
        }
      } catch (response) {
        emit(
          state.copyWith(
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
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onUpdatePatientInfor(
    UpdatePatientInforEvent event,
    Emitter<SettingState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        UpdatePatientInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _patientUseCase.updatePatientInforEntity(
            event.id, event.patientInforEntity);
        final newViewModel = state.viewModel;
        emit(UpdatePatientInforState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ));
      } catch (e) {
        emit(
          state.copyWith(
              status: BlocStatusState.failure, viewModel: state.viewModel),
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

  Future<void> _onUpdateRelativeInfor(
    UpdateRelativeInforEvent event,
    Emitter<SettingState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        UpdateRelativeInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _relativeInforUsecase.updateRelativeInforEntity(
            event.id, event.relativeInforEntity);
        final newViewModel = state.viewModel;
        emit(UpdateRelativeInforState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ));
      } catch (e) {
        emit(
          state.copyWith(
              status: BlocStatusState.failure, viewModel: state.viewModel),
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

//
  Future<void> _onUpdateDoctorInfor(
    UpdateDoctorInforEvent event,
    Emitter<SettingState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        UpdateDoctorInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _doctorInforUsecase.updateDoctorInforEntity(
            event.id, event.doctorInforEntity);
        final newViewModel = state.viewModel;
        emit(UpdateDoctorInforState(
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
