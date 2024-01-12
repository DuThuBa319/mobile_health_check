import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/domain/network/network_info.dart';
import 'package:mobile_health_check/domain/usecases/change_pass_usecase/change_pass_usecase.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';

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
  final NetworkInfo networkInfo;

  SettingBloc(
      this.networkInfo,
      this._patientUseCase,
      this._doctorInforUsecase,
      this._relativeInforUsecase,
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
    if (await networkInfo.isConnected == true) {
      if (event.changePassEntity.currentPassword == null ||
          event.changePassEntity.currentPassword?.trim() == '' ||
          event.changePassEntity.newPassword == null ||
          event.changePassEntity.newPassword?.trim() == '') {
        if (event.changePassEntity.currentPassword == null ||
            event.changePassEntity.currentPassword?.trim() == '') {
          emit(
            ChangePassState(
              status: BlocStatusState.failure,
              viewModel: const _ViewModel(errorEmptyCurrentPassword: true),
            ),
          );
        }
        if (event.changePassEntity.newPassword == null ||
            event.changePassEntity.newPassword?.trim() == '') {
          emit(
            ChangePassState(
              status: BlocStatusState.failure,
              viewModel: const _ViewModel(
                errorEmptyNewPassword: true,
              ),
            ),
          );
        }
        if ((event.changePassEntity.newPassword == null ||
                event.changePassEntity.newPassword?.trim() == '') &&
            (event.changePassEntity.currentPassword == null ||
                event.changePassEntity.currentPassword?.trim() == '')) {
          emit(
            ChangePassState(
              status: BlocStatusState.failure,
              viewModel: const _ViewModel(
                errorEmptyCurrentPassword: true,
                errorEmptyNewPassword: true,
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
        emit(ChangePassState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ));
      } on DioException catch (e) {
        if (e.response?.data == "Password is invalid") {
          emit(ChangePassState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isCurrentPassWrong: true,
            ),
          ));
        }
      } catch (response) {
        emit(
          ChangePassState(
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
        ChangePassState(
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

  Future<void> _onUpdatePatientInfor(
    UpdatePatientInforEvent event,
    Emitter<SettingState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        UpdatePatientInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _patientUseCase.updatePatientInforEntity(
            event.id, event.patientInforEntity);

        emit(UpdatePatientInforState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ));
      } catch (e) {
        emit(
          UpdatePatientInforState(
              status: BlocStatusState.failure,
              viewModel: state.viewModel.copyWith(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .error)),
        );
      }
    } else {
      emit(
        UpdatePatientInforState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onUpdateRelativeInfor(
    UpdateRelativeInforEvent event,
    Emitter<SettingState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        UpdateRelativeInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _relativeInforUsecase.updateRelativeInforEntity(
            event.id, event.relativeInforEntity);
        emit(UpdateRelativeInforState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ));
      } catch (e) {
        emit(
          UpdateRelativeInforState(
              status: BlocStatusState.failure,
              viewModel: state.viewModel.copyWith(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .error)),
        );
      }
    } else {
      emit(
        UpdateRelativeInforState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

//
  Future<void> _onUpdateDoctorInfor(
    UpdateDoctorInforEvent event,
    Emitter<SettingState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        UpdateDoctorInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _doctorInforUsecase.updateDoctorInforEntity(
            event.id, event.doctorInforEntity);
        emit(UpdateDoctorInforState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ));
      } catch (e) {
        emit(
          UpdateDoctorInforState(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        UpdateDoctorInforState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }
}
