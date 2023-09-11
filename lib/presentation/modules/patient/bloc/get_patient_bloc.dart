import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/data/models/patient_infor_model/patient_infor_model.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';

import 'package:mobile_health_check/domain/entities/patient_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';

import '../../../../data/models/patient_list_model/patient_list_model.dart';
import '../../../../domain/usecases/patient_usecase/patient_usecase.dart';
import '../../../common_widget/enum_common.dart';
part 'get_patient_event.dart';
part 'get_patient_state.dart';

@injectable
class GetPatientBloc extends Bloc<PatientEvent, GetPatientState> {
  final PatientUsecase _patientUseCase;
  final DoctorInforUsecase _doctorInforUsecase;
  GetPatientBloc(this._patientUseCase, this._doctorInforUsecase)
      : super(GetPatientInitialState()) {
    on<GetPatientListEvent>(_onGetPatientList);
    on<FilterPatientEvent>(_onSearchPatient);
    on<UpdatePatientInforEvent>(_onUpdatePatientInfor);

    // on<RegistPatientEvent>(_registPatient);
    on<GetPatientInforEvent>(_getPatientInfor);
    // on<GetBloodPressureHistoryDataEvent>(_onGetBloodPressureHistoryData);
    // on<GetBloodSugarHistoryDataEvent>(_onGetBloodSugarHistoryData);
    // on<GetTemperatureHistoryDataEvent>(_onGetTemperatureHistoryData);
    // on<GetBloodPressureHistoryInitDataEvent>(
    //     _onGetBloodPressureHistoryInitData);
    // on<GetBloodSugarHistoryInitDataEvent>(_onGetBloodSugarHistoryInitData);
    // on<GetTemperatureHistoryInitDataEvent>(_onGetTemperatureHistoryInitData);
  }

  Future<void> _onGetPatientList(
    GetPatientListEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    emit(
      GetPatientListState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      // final response = await _patientUseCase.getPatientListEntity();
      // final newViewModel = state.viewModel.copyWith(patientEntity: response);
      final response = await _doctorInforUsecase.getDoctorInforEntity(event.id);
      final newViewModel =
          state.viewModel.copyWith(doctorInforEntity: response);
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
  }

  Future<void> _onSearchPatient(
    FilterPatientEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    emit(
      GetPatientListState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final patients = await _patientUseCase.getPatientListEntity();
      final filteredPatients = patients
          ?.where((value) =>
              value.name.toLowerCase().contains(event.searchText.toLowerCase()))
          .toList();
      final newViewModel =
          state.viewModel.copyWith(patientEntity: filteredPatients);
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
  }

  // Future<void> _registPatient(
  //   RegistPatientEvent event,
  //   Emitter<GetPatientState> emit,
  // ) async {
  //   emit(
  //     RegistPatientState(
  //       status: BlocStatusState.loading,
  //       viewModel: state.viewModel,
  //     ),
  //   );
  //   try {
  //     final newPatient = await _PatientPatientCase.addPatientEntity(event.Patient);

  //     final newViewModel = state.viewModel.copyWith(
  //       PatientEntity: state.viewModel.PatientEntity,
  //     );

  //     emit(
  //       RegistPatientState(
  //         status: BlocStatusState.success,
  //         viewModel: newViewModel,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         status: BlocStatusState.failure,
  //         viewModel: state.viewModel,
  //       ),
  //     );
  //   }
  // }

  Future<void> _getPatientInfor(
    GetPatientInforEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    emit(
      GetPatientInforState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await _patientUseCase.getPatientInforEntity(event.id);
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
  }

  Future<void> _onUpdatePatientInfor(
    UpdatePatientInforEvent event,
    Emitter<GetPatientState> emit,
  ) async {
    emit(
      UpdatePatientInforState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await _patientUseCase.updatePatientInforEntity(event.id, event.model);
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
