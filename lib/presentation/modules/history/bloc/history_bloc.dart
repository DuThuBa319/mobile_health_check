import 'package:bloc/bloc.dart';
import 'package:mobile_health_check/domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../common_widget/enum_common.dart';
part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final BloodPressureUsecase bloodPressureUseCase;
  HistoryBloc(this.bloodPressureUseCase) : super(HistoryInitialState()) {
    on<GetHistoryDataEvent>(_onGetHistoryData);
  }
  Future<void> _onGetHistoryData(
    GetHistoryDataEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(
      GetHistoryDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final responses =
          await bloodPressureUseCase.getListBloodPressureEntities();
      List<BloodPressureEntity>? listBloodPressure = [];
      for (var response in responses) {
        if (response.updatedDate!.isAfter(event.startDate) &&
            response.updatedDate!.isBefore(event.endDate)) {
          listBloodPressure.add(response);
        }
      }
      final newViewModel =
          state.viewModel.copyWith(listBloodPressure: listBloodPressure);
      emit(
        state.copyWith(
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
  }
}

enum ReadDataTask { temperature, bloodPressure, bloodGlucose }
