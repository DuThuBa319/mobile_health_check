import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/admin_infor_entity.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/domain/network/network_info.dart';
import 'package:mobile_health_check/domain/usecases/admin_usecase/admin_usecase.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';

import '../../../../classes/language.dart';

import '../../../../common/singletons.dart';

import '../../../common_widget/enum_common.dart';
part 'admin_event.dart';
part 'admin_state.dart';

@injectable
class GetDoctorBloc extends Bloc<GetDoctorEvent, GetDoctorState> {
  final DoctorInforUsecase _doctorInforUsecase;
  final NetworkInfo networkInfo;
  final AdminUsecase _adminUsecase;
  GetDoctorBloc(
    this._adminUsecase,
    this._doctorInforUsecase,
    this.networkInfo,
  ) : super(GetDoctorInitialState()) {
    on<GetDoctorListEvent>(_onGetDoctorList);
    on<FilterDoctorEvent>(_onSearchDoctor);
    on<DeleteDoctorEvent>(_onDeleteDoctor);
    on<GetDoctorInforEvent>(_getDoctorInfor);
    on<RegistDoctorEvent>(_onRegistDoctor);
  }
  Future<void> _onGetDoctorList(
    GetDoctorListEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        GetDoctorListState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final response =
            await _adminUsecase.getAdminInforEntity(adminId: event.admindId);
        final newViewModel = state.viewModel.copyWith(
            adminInforEntity: response, allDoctorEntity: response?.doctors);
        emit(GetDoctorListState(
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
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onSearchDoctor(
    FilterDoctorEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        SearchDoctorState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final response =
            await _adminUsecase.getAdminInforEntity(adminId: event.adminId);

        // List<DoctorEntity>? searchResult = [];
        final filteredDoctors = response?.doctors
            ?.where((value) => value.name
                .toLowerCase()
                .contains(event.searchText.toLowerCase()))
            .toList();
        final newViewModel =
            state.viewModel.copyWith(allDoctorEntity: filteredDoctors);
        emit(SearchDoctorState(
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
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _getDoctorInfor(
    GetDoctorInforEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        GetDoctorInforState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final doctorInforEntity =
            await _doctorInforUsecase.getDoctorInforEntity(event.doctorId);
        final newViewModel =
            state.viewModel.copyWith(doctorInforEntity: doctorInforEntity);
        emit(GetDoctorInforState(
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
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onRegistDoctor(
    RegistDoctorEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        RegistDoctorState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );

      if ((event.accountEntity!.name == null ||
              event.accountEntity!.name?.trim() == '') &&
          (event.accountEntity!.phoneNumber != null &&
              event.accountEntity!.phoneNumber?.trim() != '' &&
              event.accountEntity!.phoneNumber!.length >= 10 &&
              event.accountEntity!.phoneNumber!.length <= 11)) {
        emit(
          RegistDoctorState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              errorEmptyName:
                  translation(navigationService.navigatorKey.currentContext!)
                      .pleaseEnterDoctorName,
            ),
          ),
        );
        return;
      }

      if ((event.accountEntity!.name != null &&
              event.accountEntity!.name?.trim() != '') &&
          (event.accountEntity!.phoneNumber == null ||
              event.accountEntity!.phoneNumber?.trim() == '' ||
              event.accountEntity!.phoneNumber!.length < 10 ||
              event.accountEntity!.phoneNumber!.length > 11)) {
        emit(
          RegistDoctorState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              errorEmptyPhoneNumber:
                  translation(navigationService.navigatorKey.currentContext!)
                      .invalidPhonenumber,
            ),
          ),
        );
        return;
      }
      if ((event.accountEntity!.name == null ||
              event.accountEntity!.name?.trim() == '') &&
          (event.accountEntity!.phoneNumber == null ||
              event.accountEntity!.phoneNumber?.trim() == '' ||
              event.accountEntity!.phoneNumber!.length < 10 ||
              event.accountEntity!.phoneNumber!.length > 11)) {
        emit(
          RegistDoctorState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
              errorEmptyName:
                  translation(navigationService.navigatorKey.currentContext!)
                      .pleaseEnterDoctorName,
              errorEmptyPhoneNumber:
                  translation(navigationService.navigatorKey.currentContext!)
                      .invalidPhonenumber,
            ),
          ),
        );
        return;
      }

      try {
        await _adminUsecase.createDoctorAccountEntity(
            event.accountEntity!, userDataData.getUser()!.id);
        final newViewModel = state.viewModel;
        emit(
          RegistDoctorState(
            status: BlocStatusState.success,
            viewModel: newViewModel,
          ),
        );
      } on DioException catch (e) {
        if (e.response?.data ==
            "This phone number has been already registered by another account") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .duplicatedDoctorPhoneNumber),
          ));
        }
      } catch (response) {
        emit(state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .error),
        ));
      }
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onDeleteDoctor(
    DeleteDoctorEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        DeleteDoctorState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _adminUsecase.deleteDoctorEntity(event.doctorId);
        // final response =
        //       await _adminUsecase.getAdminInforEntity(adminId: event.adminId);
        // final newViewModel =
        //     state.viewModel.copyWith(allDoctorEntity: response?.doctors);
        emit(DeleteDoctorState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ));
      } on DioException catch (e) {
        if (e.response?.data ==
            "Cannot delete this account because it is still in a relationship with another account.") {
          emit(state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .cannotDeleteDoctor),
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
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }
}
