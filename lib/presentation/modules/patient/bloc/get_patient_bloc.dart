import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/domain/usecases/change_pass_usecase/change_pass_usecase.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';

import '../../../../data/models/relative_model/relative_infor_model.dart';
import '../../../../domain/entities/change_password_entity.dart';
import '../../../../domain/entities/login_entity_group/sign_in_entity.dart';
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
  final Connectivity _connectivity;
  GetPatientBloc(
      this._patientUseCase,
      this._doctorInforUsecase,
      this._relativeInforUsecase,
      this._connectivity,
      this.notificationUsecase,
      this.changePassUsecase)
      : super(GetPatientInitialState()) {
    on<GetPatientListEvent>(_onGetPatientList);
    on<GetPatientListOfRelativeEvent>(_onGetPatientListOfRelative);
    on<FilterPatientEvent>(_onSearchPatient);
    on<UpdatePatientInforEvent>(_onUpdatePatientInfor);
    on<UpdateRelativeInforEvent>(_onUpdateRelativeInfor);
    on<UpdateDoctorInforEvent>(_onUpdateDoctorInfor);
    on<RegistPatientEvent>(_onAddPatient);
    on<RegistRelativeEvent>(_onAddRelative);
    on<GetPatientInforEvent>(_getPatientInfor);
    on<DeleteRelativeEvent>(_onDeleteRelative);
    on<DeletePatientEvent>(_onDeletePatient);
    on<ChangePassEvent>(_onChangePass);
  }

  Future<void> _onChangePass(
    ChangePassEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
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
        final numberOfNotificationsEntity = await notificationUsecase
            .getNumberOfNotificationEntity(event.userId);
        final response =
            await _doctorInforUsecase.getDoctorInforEntity(event.userId);
        final newViewModel = state.viewModel.copyWith(
            doctorInforEntity: response,
            totalCount: numberOfNotificationsEntity);
        emit(GetPatientListState(
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

  Future<void> _onGetPatientListOfRelative(
    GetPatientListOfRelativeEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        GetPatientListOfRelativeState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final numberOfNotificationsEntity = await notificationUsecase
            .getNumberOfNotificationEntity(event.relativeId);
        final response = await _relativeInforUsecase
            .getRelativeInforEntity(event.relativeId);

        final newViewModel = state.viewModel.copyWith(
            relativeInforEntity: response,
            totalCount: numberOfNotificationsEntity);
        emit(GetPatientListOfRelativeState(
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
        if (userDataData.getUser()!.role! == 'doctor') {
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
        if (userDataData.getUser()!.role! == 'relative') {
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

  Future<void> _onAddPatient(
    RegistPatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        RegistPatientState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        // final accountEntity =
        await _doctorInforUsecase.addPatientEntity(
            event.doctorId, event.patientInforModel);
        // firebaseAuthService.createUserWithEmailAndPassword(
        //     email: '${event.patientInforModel!.phoneNumber}@gmail.com',
        //     password: event.patientInforModel!.phoneNumber,
        //     id: accountEntity?.id ?? '--',
        //     role: 'patient',
        //     name: event.patientInforModel!.name,
        //     phoneNumber: event.patientInforModel!.phoneNumber);
        final newViewModel = state.viewModel;
        emit(
          RegistPatientState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
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
    } else {
      emit(
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onAddRelative(
    RegistRelativeEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        RegistRelativeState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        // final accountEntity =
        await _patientUseCase.addRelativeInforEntity(
            event.patientId, event.relativeInforModel);
        // firebaseAuthService.createUserWithEmailAndPassword(
        //     email: '${event.relativeInforModel!.phoneNumber}@gmail.com',
        //     password: event.relativeInforModel!.phoneNumber,
        //     id: accountEntity?.id ?? '--',
        //     role: 'patient',
        //     name: event.relativeInforModel!.name,
        //     phoneNumber: event.relativeInforModel!.phoneNumber);
        final newViewModel = state.viewModel;
        emit(RegistRelativeState(
            status: BlocStatusState.success, viewModel: newViewModel));
      } catch (e) {
        emit(RegistRelativeState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
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

  Future<void> _onUpdatePatientInfor(
    UpdatePatientInforEvent event,
    Emitter<GetPatientState> emit,
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

  Future<void> _onUpdateRelativeInfor(
    UpdateRelativeInforEvent event,
    Emitter<GetPatientState> emit,
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

  Future<void> _onUpdateDoctorInfor(
    UpdateDoctorInforEvent event,
    Emitter<GetPatientState> emit,
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

  Future<void> _onDeleteRelative(
    DeleteRelativeEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        DeleteRelativeState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _doctorInforUsecase.deleteRelativeEntity(
            event.relativeId, event.patientId);
        final newViewModel = state.viewModel;
        emit(DeleteRelativeState(
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
        // await _doctorInforUsecase.deleteRelationshipDoctorAndPatientEntity(
        //     event.doctorId, event.patientId);
        await _doctorInforUsecase.deletePatientEntity(event.patientId);
        final response =
            await _doctorInforUsecase.getDoctorInforEntity(event.doctorId);
        final newViewModel =
            state.viewModel.copyWith(doctorInforEntity: response);
        emit(DeletePatientState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ));
        // emit(
        //   GetPatientListState(
        //     status: BlocStatusState.loading,
        //     viewModel: state.viewModel,
        //   ),
        // );
        // emit(GetPatientListState(
        //   status: BlocStatusState.success,
        //   viewModel: newViewModel,
        // ));
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

//   Future<void> _onGetBloodPressureHistoryData(
//     GetBloodPressureHistoryDataEvent event,
//     Emitter<GetPatientState> emit,
//   ) async {
//     emit(
//       GetPatientInforState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );
//     try {
//       final responses =
//           await bloodPressureUseCase.getListBloodPressureEntities();

//       List<BloodPressureEntity>? listBloodPressure = [];
//       for (var response in responses) {
//         if (response.updatedDate!.isAfter(event.startDate) &&
//             response.updatedDate!.isBefore(event.endDate)) {
//           listBloodPressure.add(response);
//           print(listBloodPressure);
//         }
//       }
//       final newViewModel =
//           state.viewModel.copyWith(listBloodPressure: listBloodPressure);
//       emit(
//         state.copyWith(
//           status: BlocStatusState.success,
//           viewModel: newViewModel,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }

//   ////
//   Future<void> _onGetBloodPressureHistoryInitData(
//     GetBloodPressureHistoryInitDataEvent event,
//     Emitter<GetPatientState> emit,
//   ) async {
//     emit(
//       GetPatientInforState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );
//     try {
//       final responses =
//           await bloodPressureUseCase.getListBloodPressureEntities();
//       List<BloodPressureEntity>? listBloodPressure = [];
//       for (var response in responses) {
//         listBloodPressure.add(response);
//         print(listBloodPressure);
//       }
//       final newViewModel =
//           state.viewModel.copyWith(listBloodPressure: listBloodPressure);
//       emit(
//         state.copyWith(
//           status: BlocStatusState.success,
//           viewModel: newViewModel,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }

//   ///

//   Future<void> _onGetBloodSugarHistoryInitData(
//     GetBloodSugarHistoryInitDataEvent event,
//     Emitter<GetPatientState> emit,
//   ) async {
//     emit(
//       GetPatientInforState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );
//     try {
//       final responses = await bloodSugarUseCase.getListBloodSugarEntities();

//       final newViewModel = state.viewModel.copyWith(listBloodSugar: responses);
//       emit(
//         state.copyWith(
//           status: BlocStatusState.success,
//           viewModel: newViewModel,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }
// /////

//   Future<void> _onGetBloodSugarHistoryData(
//     GetBloodSugarHistoryDataEvent event,
//     Emitter<GetPatientState> emit,
//   ) async {
//     emit(
//       GetPatientInforState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );
//     try {
//       final responses = await bloodSugarUseCase.getListBloodSugarEntities();
//       List<BloodSugarEntity>? listBloodSugar = [];
//       for (var response in responses) {
//         if (response.updatedDate!.isAfter(event.startDate) &&
//             response.updatedDate!.isBefore(event.endDate)) {
//           listBloodSugar.add(response);
//         }
//       }
//       final newViewModel = state.viewModel.copyWith(
//         listBloodSugar: listBloodSugar,
//       );
//       emit(
//         state.copyWith(
//           status: BlocStatusState.success,
//           viewModel: newViewModel,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }
// //////

//   Future<void> _onGetTemperatureHistoryInitData(
//     GetTemperatureHistoryInitDataEvent event,
//     Emitter<GetPatientState> emit,
//   ) async {
//     emit(
//       GetPatientInforState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );
//     try {
//       final responses = await temperatureUsecase.getListTemperatureEntities();

//       final newViewModel = state.viewModel.copyWith(listTemperature: responses);
//       emit(
//         state.copyWith(
//           status: BlocStatusState.success,
//           viewModel: newViewModel,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }

// //////
//   Future<void> _onGetTemperatureHistoryData(
//     GetTemperatureHistoryDataEvent event,
//     Emitter<GetPatientState> emit,
//   ) async {
//     emit(
//       GetPatientInforState(
//         status: BlocStatusState.loading,
//         viewModel: state.viewModel,
//       ),
//     );
//     try {
//       final responses = await temperatureUsecase.getListTemperatureEntities();
//       List<TemperatureEntity>? listTemperature = [];
//       for (var response in responses) {
//         if (response.updatedDate!.isAfter(event.startDate) &&
//             response.updatedDate!.isBefore(event.endDate)) {
//           listTemperature.add(response);
//         }
//       }
//       final newViewModel =
//           state.viewModel.copyWith(listTemperature: listTemperature);
//       emit(
//         state.copyWith(
//           status: BlocStatusState.success,
//           viewModel: newViewModel,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: BlocStatusState.failure,
//           viewModel: state.viewModel,
//         ),
//       );
//     }
//   }
// }

// enum ReadDataTask { temperature, bloodPressure, bloodGlucose }
}
