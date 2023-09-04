import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';

import '../../../../domain/entities/notificaion_onesignal_entity.dart';
import '../../../../presentation/common_widget/enum_common.dart';
part 'notification_event.dart';
part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUsecase notificationUsecase;
  NotificationBloc(this.notificationUsecase)
      : super(NotificationInitialState()) {
    on<GetNotificationListEvent>(_onGetNotificationList);
    on<SetReadedNotificationEvent>(_setReadedNotification);
  }

  Future<void> _onGetNotificationList(
    GetNotificationListEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      GetNotificationListState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response =
          await notificationUsecase.getNotificationListEntity(event.id);
      final newViewModel =
          state.viewModel.copyWith(notificationEntity: response);
      emit(GetNotificationListState(
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

  Future<void> _setReadedNotification(
    SetReadedNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      SetReadedNotificationState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await notificationUsecase
          .setReadedNotificationEntity(event.notificationId);

      final newViewModel = state.viewModel;
      emit(SetReadedNotificationState(
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
