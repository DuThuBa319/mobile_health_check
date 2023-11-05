import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/service/navigation/navigation_service.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/domain/usecases/admin_usecase/admin_usecase.dart';
import 'package:mobile_health_check/domain/usecases/change_pass_usecase/change_pass_usecase.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';
import 'package:mobile_health_check/domain/usecases/reset_password_usecase/reset_password_usecase.dart';

import '../../../../classes/language.dart';
import '../../../../di/di.dart';
import '../../../../domain/entities/login_entity_group/account_entity.dart';
import '../../../../domain/entities/relative_infor_entity.dart';
import '../../../../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';
import '../../../../domain/usecases/patient_usecase/patient_usecase.dart';
import '../../../../domain/usecases/relative_infor_usecase/relative_infor_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'get_patient_event.dart';
part 'get_patient_state.dart';

@injectable
class GetPatientBloc extends Bloc<PatientEvent, GetPatientState> {
  final ResetPasswordUsecase _resetPasswordUsecase;
  final PatientUsecase _patientUseCase;
  final DoctorInforUsecase _doctorInforUsecase;
  final RelativeInforUsecase _relativeInforUsecase;
  final NotificationUsecase notificationUsecase;
  final ChangePassUsecase changePassUsecase;
  final Connectivity _connectivity;
  final AdminUsecase _adminUsecase;
  GetPatientBloc(
      this._resetPasswordUsecase,
      this._adminUsecase,
      this._patientUseCase,
      this._doctorInforUsecase,
      this._relativeInforUsecase,
      this._connectivity,
      this.notificationUsecase,
      this.changePassUsecase)
      : super(GetPatientInitialState()) {
    on<GetPatientListEvent>(_onGetPatientList);
    on<FilterPatientEvent>(_onSearchPatient);
    on<RegistPatientEvent>(_onAddPatient);
    on<RegistRelativeEvent>(_onAddRelative);
    on<GetPatientInforEvent>(_getPatientInfor);
    on<RemoveRelationshipRaPEvent>(_onRemoveRelationshipRaP);
    on<DeletePatientEvent>(_onDeletePatient);
    on<ResetPasswordCustomerEvent>(_onResetPassword);

    // on<ChangePassEvent>(_onChangePass);
    on<GetDoctorListEvent>(_onGetDoctorList);
  }

//! RESET PASSWORD

  Future<void> _onResetPassword(
    ResetPasswordCustomerEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        ResetPasswordCustomerState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _resetPasswordUsecase.resetPasswordEntity(userId: event.userId);

        emit(ResetPasswordCustomerState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
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

//! GET DOCTOR LIST
  Future<void> _onGetDoctorList(
    GetDoctorListEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetDoctorListState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      try {
        final allDoctorEntity = await _adminUsecase.getAllDoctorEntity();
        final newViewModel =
            state.viewModel.copyWith(allDoctorEntity: allDoctorEntity);

        emit(GetDoctorListState(
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

//! GET PATIENT LIST IN DOCTOR APP
  Future<void> _onGetPatientList(
    GetPatientListEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetPatientListState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      try {
        final unreadNotificationsCount = await notificationUsecase
            .getUnreadCountNotificationEntity(event.userId);
        if (userDataData.getUser()?.role == UserRole.doctor) {
          final response =
              await _doctorInforUsecase.getDoctorInforEntity(event.userId);
          final newViewModel = state.viewModel.copyWith(
              doctorInforEntity: response,
              unreadCount: unreadNotificationsCount,
              patientEntities: response?.patients);

          emit(GetPatientListState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ));
        } else if (userDataData.getUser()?.role == UserRole.relative) {
          final response =
              await _relativeInforUsecase.getRelativeInforEntity(event.userId);

          final newViewModel = state.viewModel.copyWith(
              relativeInforEntity: response,
              unreadCount: unreadNotificationsCount,
              patientEntities: response?.patients);

          emit(GetPatientListState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ));
        }
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

//! SEARCH PATIENT
  Future<void> _onSearchPatient(
    FilterPatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        SearchPatientState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        if (userDataData.getUser()!.role! == UserRole.doctor) {
          final response =
              await _doctorInforUsecase.getDoctorInforEntity(event.id);
          final allPatients = response!.patients;
          // List<PatientEntity>? searchResult = [];
          final filteredPatients = allPatients
              ?.where((value) => value.name
                  .toLowerCase()
                  .contains(event.searchText.toLowerCase()))
              .toList();
          // searchResult = filteredPatients;
          final newViewModel =
              state.viewModel.copyWith(patientEntities: filteredPatients);
          emit(SearchPatientState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ));
        }
        if (userDataData.getUser()!.role! == UserRole.relative) {
          final response =
              await _relativeInforUsecase.getRelativeInforEntity(event.id);
          final allPatients = response!.patients;
          // List<PatientEntity>? searchResult = [];
          final filteredPatients = allPatients
              ?.where((value) => value.name
                  .toLowerCase()
                  .contains(event.searchText.toLowerCase()))
              .toList();
          // searchResult = filteredPatients;
          final newViewModel =
              state.viewModel.copyWith(patientEntities: filteredPatients);
          emit(SearchPatientState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ));
        }
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

//! ADD PATIENT
  Future<void> _onAddPatient(
    RegistPatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    NavigationService navigationService = injector<NavigationService>();
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        RegistPatientState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      if (event.accountEntity?.name == null ||
          event.accountEntity?.name?.trim() == '' ||
          event.accountEntity?.phoneNumber == null ||
          event.accountEntity?.phoneNumber?.trim() == '' ||
          event.accountEntity!.phoneNumber!.length < 10 ||
          event.accountEntity!.phoneNumber!.length > 11) {
        if (event.accountEntity?.name == null ||
            event.accountEntity?.name?.trim() == '') {
          emit(
            RegistPatientState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyName:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterPatientName,
              ),
            ),
          );
        }
        if (event.accountEntity?.phoneNumber == null ||
            event.accountEntity?.phoneNumber?.trim() == '' ||
            event.accountEntity!.phoneNumber!.length < 10 ||
            event.accountEntity!.phoneNumber!.length > 11) {
          emit(
            RegistPatientState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyPhoneNumber:
                    translation(navigationService.navigatorKey.currentContext!)
                        .invalidPhonenumber,
              ),
            ),
          );
        }
        if ((event.accountEntity?.phoneNumber == null ||
                event.accountEntity?.phoneNumber?.trim() == '' ||
                event.accountEntity!.phoneNumber!.length < 10 ||
                event.accountEntity!.phoneNumber!.length > 11) &&
            (event.accountEntity?.name == null ||
                event.accountEntity?.name?.trim() == '')) {
          emit(
            RegistPatientState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyName:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterPatientName,
                errorEmptyPhoneNumber:
                    translation(navigationService.navigatorKey.currentContext!)
                        .invalidPhonenumber,
              ),
            ),
          );
        }

        return;
      }

      try {
        await _doctorInforUsecase.addPatientEntity(
            event.doctorId, event.accountEntity);
        final newViewModel = state.viewModel;
        emit(
          RegistPatientState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } on DioException catch (e) {
        if (e.response?.data ==
            "The relationship between these entities has been existed") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .duplicatedRelationshipPAD),
          ));
        } else if (e.response?.data ==
            "This patient has been managed by another doctor") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .hasDoctorBefore),
          ));
        }
      } catch (response) {
        emit(RegistPatientState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error),
        ));
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

//! ADD RELATIVE
  Future<void> _onAddRelative(
    RegistRelativeEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    NavigationService navigationService = injector<NavigationService>();
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        RegistRelativeState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      if (event.accountEntity?.name == null ||
          event.accountEntity?.name?.trim() == '' ||
          event.accountEntity?.phoneNumber == null ||
          event.accountEntity?.phoneNumber?.trim() == '' ||
          event.accountEntity!.phoneNumber!.length < 10 ||
          event.accountEntity!.phoneNumber!.length > 11) {
        if (event.accountEntity?.name == null ||
            event.accountEntity?.name?.trim() == '') {
          emit(
            RegistRelativeState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyName:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterRelativeName,
              ),
            ),
          );
        }
        if (event.accountEntity?.phoneNumber == null ||
            event.accountEntity?.phoneNumber?.trim() == '' ||
            event.accountEntity!.phoneNumber!.length < 10 ||
            event.accountEntity!.phoneNumber!.length > 11) {
          emit(
            RegistRelativeState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyPhoneNumber:
                    translation(navigationService.navigatorKey.currentContext!)
                        .invalidPhonenumber,
              ),
            ),
          );
        }
        if ((event.accountEntity?.phoneNumber == null ||
                event.accountEntity?.phoneNumber?.trim() == '' ||
                event.accountEntity!.phoneNumber!.length < 10 ||
                event.accountEntity!.phoneNumber!.length > 11) &&
            (event.accountEntity?.name == null ||
                event.accountEntity?.name?.trim() == '')) {
          emit(
            RegistRelativeState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                errorEmptyName:
                    translation(navigationService.navigatorKey.currentContext!)
                        .pleaseEnterRelativeName,
                errorEmptyPhoneNumber:
                    translation(navigationService.navigatorKey.currentContext!)
                        .invalidPhonenumber,
              ),
            ),
          );
        }
        return; //? Return để dừng, nếu không return thì sẽ thực hiện tiếp những dòng dưới
      }

      try {
        await _patientUseCase.addRelativeInforEntity(
            event.patientId, event.accountEntity);
        emit(RegistRelativeState(
            status: BlocStatusState.success, viewModel: state.viewModel));
      } on DioException catch (e) {
        if (e.response?.data ==
            "The relationship between these entities has been existed") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .duplicatedRelationshipPAR),
          ));
        }
        if (e.response?.data ==
            "The number of relatives belonging to this patient is already maxium") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .maximumRelativeCount),
          ));
        }
      } catch (response) {
        emit(RegistRelativeState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error),
        ));
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

//! GET PATIENT INFOR
  Future<void> _getPatientInfor(
    GetPatientInforEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetPatientInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final response =
            await _patientUseCase.getPatientInforEntity(event.patientId);
        final newViewModel =
            state.viewModel.copyWith(patientInforEntity: response);
        emit(GetPatientInforState(
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

  Future<void> _onRemoveRelationshipRaP(
    RemoveRelationshipRaPEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        RemoveRelationshipRaPState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _doctorInforUsecase.removeRelationshipRaPEntity(
            event.relativeId, event.patientId);
        final newViewModel = state.viewModel;
        emit(RemoveRelationshipRaPState(
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

  Future<void> _onDeletePatient(
    DeletePatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        DeletePatientState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _doctorInforUsecase.deletePatientEntity(event.patientId);

        emit(DeletePatientState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
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
