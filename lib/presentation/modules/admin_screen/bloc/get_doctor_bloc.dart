import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/cell_person_entity.dart';
import 'package:mobile_health_check/domain/entities/doctor_infor_entity.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/entities/login_entity_group/account_entity.dart';
import 'package:mobile_health_check/domain/usecases/admin_usecase/admin_usecase.dart';
import 'package:mobile_health_check/domain/usecases/doctor_infor_usecase/doctor_infor_usecase.dart';

import '../../../common_widget/enum_common.dart';
part 'get_doctor_event.dart';
part 'get_doctor_state.dart';

@injectable
class GetDoctorBloc extends Bloc<GetDoctorEvent, GetDoctorState> {
  final DoctorInforUsecase _doctorInforUsecase;
  final Connectivity _connectivity;
  final AdminUsecase _adminUsecase;
  GetDoctorBloc(
    this._adminUsecase,
    this._doctorInforUsecase,
    this._connectivity,
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

  Future<void> _onSearchDoctor(
    FilterDoctorEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        SearchDoctorState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final allDoctorEntity = await _adminUsecase.getAllDoctorEntity();
        // List<DoctorEntity>? searchResult = [];
        final filteredDoctors = allDoctorEntity
            .where((value) => value.name
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
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _getDoctorInfor(
    GetDoctorInforEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
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
        WifiDisconnectState(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ),
      );
    }
  }

  Future<void> _onRegistDoctor(
    RegistDoctorEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        RegistDoctorState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _adminUsecase.createDoctorAccountEntity(event.accountEntity);
        final newViewModel = state.viewModel;
        emit(
          RegistDoctorState(
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

  Future<void> _onDeleteDoctor(
    DeleteDoctorEvent event,
    Emitter<GetDoctorState> emit,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      emit(
        DeleteDoctorState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await _adminUsecase.deleteDoctorEntity(event.doctorId);
        final response = await _adminUsecase.getAllDoctorEntity();
        final newViewModel =
            state.viewModel.copyWith(allDoctorEntity: response);
        emit(DeleteDoctorState(
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
