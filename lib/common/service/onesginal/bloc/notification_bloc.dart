import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../presentation/common_widget/enum_common.dart';
part 'notification_event.dart';
part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
 NotificationBloc() : super(NotificationInitialState()) {
    on<IncreaseNotificationEvent>(_onIncreaseNotificationCount);
    on<DecreaseNotificationEvent>(_onDecreaseNotificationCount);
  }

  Future<void> _onIncreaseNotificationCount(
    IncreaseNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      UpdateNotificationState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final newViewModel = state.viewModel.copyWith(count: event.count);
      emit(UpdateNotificationState(
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

  Future<void> _onDecreaseNotificationCount(
    DecreaseNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      UpdateNotificationState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final newViewModel = state.viewModel.copyWith(count: event.count);
      emit(UpdateNotificationState(
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
