import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/domain/network/network_info.dart';
import 'package:mobile_health_check/domain/usecases/change_pass_usecase/change_pass_usecase.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';
import '../../../../classes/language.dart';
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
  final PatientUsecase _patientUseCase;
  final DoctorInforUsecase _doctorInforUsecase;
  final RelativeInforUsecase _relativeInforUsecase;
  final NotificationUsecase notificationUsecase;
  final ChangePassUsecase changePassUsecase;
  final NetworkInfo networkInfo;

  GetPatientBloc(
      this.networkInfo,
      this._patientUseCase,
      this._doctorInforUsecase,
      this._relativeInforUsecase,
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
  }

//! GET PATIENT LIST
  Future<void> _onGetPatientList(
    GetPatientListEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        GetPatientListState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final unreadNotificationsCount = await notificationUsecase
            .getUnreadCountNotificationEntity(event.userId);

        //! Doctor App
        if (userDataData.getUser()?.role == UserRole.doctor) {
          final response =
              await _doctorInforUsecase.getDoctorInforEntity(event.userId);
          final newViewModel = _ViewModel(
              doctorInforEntity: response,
              unreadCount: unreadNotificationsCount,
              patientEntities: response?.patients);
          if (response?.patients?.isEmpty == true) {
            emit(GetPatientListState(
              status: BlocStatusState.failure,
              viewModel: newViewModel.copyWith(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .noPatient),
            ));
          }
          if (response?.patients?.isNotEmpty == true) {
            emit(GetPatientListState(
              status: BlocStatusState.success,
              viewModel: newViewModel,
            ));
          }
        }
        //! Relative App
        else if (userDataData.getUser()?.role == UserRole.relative) {
          final response =
              await _relativeInforUsecase.getRelativeInforEntity(event.userId);
          final newViewModel = _ViewModel(
              relativeInforEntity: response,
              unreadCount: unreadNotificationsCount,
              patientEntities: response?.patients);
          if (response?.patients?.isEmpty == true) {
            emit(GetPatientListState(
              status: BlocStatusState.failure,
              viewModel: newViewModel.copyWith(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .noPatient),
            ));
          }
          if (response?.patients?.isNotEmpty == true) {
            emit(GetPatientListState(
              status: BlocStatusState.success,
              viewModel: newViewModel,
            ));
          }
        }
      } catch (e) {
        emit(
          GetPatientListState(
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
        GetPatientListState(
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

//! SEARCH PATIENT
  Future<void> _onSearchPatient(
    FilterPatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        SearchPatientState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        if (userDataData.getUser()?.role! == UserRole.doctor) {
          final response =
              await _doctorInforUsecase.getDoctorInforEntity(event.id);
          final allPatients = response?.patients;
          // List<PatientEntity>? searchResult = [];
          final filteredPatients = allPatients
              ?.where((value) => value.name
                  .toLowerCase()
                  .contains(event.searchText.toLowerCase()))
              .toList();
          // searchResult = filteredPatients;
          //! Nếu không có dòng dưới đây, không sử dụng copyWith chỗ này thì unreadCount sẽ mất
          final newViewModel =
              state.viewModel.copyWith(patientEntities: filteredPatients);
          if (filteredPatients?.isNotEmpty == true) {
            emit(SearchPatientState(
              status: BlocStatusState.success,
              viewModel: newViewModel,
            ));
          }
          if (filteredPatients?.isEmpty == true) {
            emit(SearchPatientState(
              status: BlocStatusState.failure,
              viewModel: newViewModel.copyWith(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .wrongSearchPatient),
            ));
          }
        }
        if (userDataData.getUser()!.role! == UserRole.relative) {
          final response =
              await _relativeInforUsecase.getRelativeInforEntity(event.id);
          final allPatients = response?.patients;
          // List<PatientEntity>? searchResult = [];
          final filteredPatients = allPatients
              ?.where((value) => value.name
                  .toLowerCase()
                  .contains(event.searchText.toLowerCase()))
              .toList();
          // searchResult = filteredPatients;
          //! Nếu không có dòng dưới đây, không sử dụng copyWith chỗ này thì unreadCount sẽ mất
          final newViewModel =
              state.viewModel.copyWith(patientEntities: filteredPatients);
          if (filteredPatients?.isNotEmpty == true) {
            emit(SearchPatientState(
              status: BlocStatusState.success,
              viewModel: newViewModel,
            ));
          }
          if (filteredPatients?.isEmpty == true) {
            emit(SearchPatientState(
              status: BlocStatusState.failure,
              viewModel: newViewModel.copyWith(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .wrongSearchPatient),
            ));
          }
        }
      } catch (e) {
        emit(
          SearchPatientState(
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
        SearchPatientState(
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

//! ADD PATIENT
  Future<void> _onAddPatient(
    RegistPatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        RegistPatientState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      if ((event.accountEntity?.name == null ||
              event.accountEntity?.name?.trim() == '') &&
          (event.accountEntity?.phoneNumber != null &&
              event.accountEntity?.phoneNumber?.trim() != '' &&
              event.accountEntity!.phoneNumber!.length >= 10 &&
              event.accountEntity!.phoneNumber!.length <= 11)) {
        emit(
          RegistPatientState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(errorEmptyName: true),
          ),
        );
        return;
      }

      if ((event.accountEntity?.name != null &&
              event.accountEntity?.name?.trim() != '') &&
          (event.accountEntity?.phoneNumber == null ||
              event.accountEntity?.phoneNumber?.trim() == '' ||
              event.accountEntity!.phoneNumber!.length < 10 ||
              event.accountEntity!.phoneNumber!.length > 11)) {
        emit(
          RegistPatientState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(errorEmptyPhoneNumber: true),
          ),
        );
        return;
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
            viewModel: const _ViewModel(
                errorEmptyName: true, errorEmptyPhoneNumber: true),
          ),
        );
        return;
      }

      try {
        await _doctorInforUsecase.addPatientEntity(
            event.doctorId, event.accountEntity);
        emit(
          RegistPatientState(
            status: BlocStatusState.success,
            viewModel: state.viewModel,
          ),
        );
      } on DioException catch (e) {
        if (e.response?.data ==
            "The relationship between these entities has been existed") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                duplicatedRelationshipPAD: true,
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .duplicatedRelationshipPAD),
          ));
        } else if (e.response?.data ==
            "This patient has been managed by another doctor") {
          emit(RegistPatientState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                hasDoctorBefore: true,
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .hasDoctorBefore),
          ));
        } else {
          {
            emit(RegistPatientState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .error),
            ));
          }
        }
      } catch (response)
      //! Lỗi server
      {
        emit(RegistPatientState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error),
        ));
      }
    } else {
      emit(
        RegistPatientState(
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

//! ADD RELATIVE
  Future<void> _onAddRelative(
    RegistRelativeEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        RegistRelativeState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      if ((event.accountEntity?.name == null ||
              event.accountEntity?.name?.trim() == '') &&
          (event.accountEntity?.phoneNumber != null &&
              event.accountEntity?.phoneNumber?.trim() != '' &&
              event.accountEntity!.phoneNumber!.length >= 10 &&
              event.accountEntity!.phoneNumber!.length <= 11)) {
        emit(
          RegistRelativeState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(errorEmptyName: true),
          ),
        );
        return;
      }
      if ((event.accountEntity?.name != null &&
              event.accountEntity?.name?.trim() != '') &&
          (event.accountEntity?.phoneNumber == null ||
              event.accountEntity?.phoneNumber?.trim() == '' ||
              event.accountEntity!.phoneNumber!.length < 10 ||
              event.accountEntity!.phoneNumber!.length > 11)) {
        emit(
          RegistRelativeState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(errorEmptyPhoneNumber: true),
          ),
        );
        return;
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
            viewModel: const _ViewModel(
                errorEmptyName: true, errorEmptyPhoneNumber: true),
          ),
        );
        return;
      }

      try {
        await _patientUseCase.addRelativeInforEntity(
            event.patientId, event.accountEntity);
        emit(RegistRelativeState(
            status: BlocStatusState.success, viewModel: state.viewModel));
      } on DioException catch (e) {
        if (e.response?.data ==
            "The relationship between these entities has been existed") {
          emit(RegistRelativeState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                duplicatedRelationshipPAR: true,
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .duplicatedRelationshipPAR),
          ));
          return;
        }

        if (e.response?.data ==
            "The number of relatives belonging to this patient is already maxium") {
          emit(RegistRelativeState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                maximumRelativeCount: true,
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .maximumRelativeCount),
          ));
          return;
        } else {
          emit(RegistRelativeState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ));
        }
      } catch (response) {
        emit(RegistRelativeState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error),
        ));
      }
    } else {
      emit(
        RegistRelativeState(
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

//! GET PATIENT INFOR
  Future<void> _getPatientInfor(
    GetPatientInforEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          GetPatientInforState(
              status: BlocStatusState.failure,
              viewModel: _ViewModel(
                  errorMessage: translation(
                          navigationService.navigatorKey.currentContext!)
                      .error)),
        );
      }
    } else {
      emit(
        GetPatientInforState(
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

//! DELETE RELATIONSHIP PATIENT & RELATIVE
  Future<void> _onRemoveRelationshipRaP(
    RemoveRelationshipRaPEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          RemoveRelationshipRaPState(
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
        RemoveRelationshipRaPState(
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

//! DELETE PATIENT
  Future<void> _onDeletePatient(
    DeletePatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          DeletePatientState(
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
        DeletePatientState(
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
