import 'package:bloc/bloc.dart';
import 'package:mobile_health_check/domain/entities/patient_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';

import '../../../../data/models/patient_list_model.dart';
import '../../../../domain/usecases/patient_usecase/patient_usecase.dart';
import '../../common_widget/enum_common.dart';
part 'get_patient_event.dart';
part 'get_patient_state.dart';

@injectable
class GetUserBloc extends Bloc<UserEvent, GetUserState> {
  final UserUsecase _userUserCase;

  GetUserBloc(this._userUserCase) : super(GetUserInitialState()) {
    on<GetListUserEvent>(_onGetUser);
    on<FilterUserEvent>(_onSearchUser);
    // on<RegistUserEvent>(_registUser);
    on<GetUserDetailEvent>(_getPatientInfor);
    // on<GetBloodPressureHistoryDataEvent>(_onGetBloodPressureHistoryData);
    // on<GetBloodSugarHistoryDataEvent>(_onGetBloodSugarHistoryData);
    // on<GetTemperatureHistoryDataEvent>(_onGetTemperatureHistoryData);
    // on<GetBloodPressureHistoryInitDataEvent>(
    //     _onGetBloodPressureHistoryInitData);
    // on<GetBloodSugarHistoryInitDataEvent>(_onGetBloodSugarHistoryInitData);
    // on<GetTemperatureHistoryInitDataEvent>(_onGetTemperatureHistoryInitData);
  }

  Future<void> _onGetUser(
    GetListUserEvent event,
    Emitter<GetUserState> emit,
  ) async {
    emit(
      GetListUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await _userUserCase.getListUserEntity();
      final newViewModel = state.viewModel.copyWith(userEntity: response);
      emit(GetListUserState(
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

  Future<void> _onSearchUser(
    FilterUserEvent event,
    Emitter<GetUserState> emit,
  ) async {
    emit(
      GetListUserState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final users = await _userUserCase.getListUserEntity();
      final filteredUsers = users
          ?.where((value) =>
              value.name.toLowerCase().contains(event.searchText.toLowerCase()))
          .toList();
      final newViewModel = state.viewModel.copyWith(userEntity: filteredUsers);
      emit(GetListUserState(
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

  // Future<void> _registUser(
  //   RegistUserEvent event,
  //   Emitter<GetUserState> emit,
  // ) async {
  //   emit(
  //     RegistUserState(
  //       status: BlocStatusState.loading,
  //       viewModel: state.viewModel,
  //     ),
  //   );
  //   try {
  //     final newUser = await _userUserCase.addUserEntity(event.user);

  //     final newViewModel = state.viewModel.copyWith(
  //       userEntity: state.viewModel.userEntity,
  //     );

  //     emit(
  //       RegistUserState(
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
    GetUserDetailEvent event,
    Emitter<GetUserState> emit,
  ) async {
    emit(
      GetUserDetailState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await _userUserCase.getPatientInforEntity(event.id);
      final newViewModel = state.viewModel.copyWith(userDetailEntity: response);
      emit(GetUserDetailState(
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
//     Emitter<GetUserState> emit,
//   ) async {
//     emit(
//       GetUserDetailState(
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
//     Emitter<GetUserState> emit,
//   ) async {
//     emit(
//       GetUserDetailState(
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
//     Emitter<GetUserState> emit,
//   ) async {
//     emit(
//       GetUserDetailState(
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
//     Emitter<GetUserState> emit,
//   ) async {
//     emit(
//       GetUserDetailState(
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
//     Emitter<GetUserState> emit,
//   ) async {
//     emit(
//       GetUserDetailState(
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
//     Emitter<GetUserState> emit,
//   ) async {
//     emit(
//       GetUserDetailState(
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
