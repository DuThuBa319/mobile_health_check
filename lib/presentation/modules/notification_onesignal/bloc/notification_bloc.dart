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
    on<DeleteNotificationEvent>(_deleteNotification);
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
      final response = await notificationUsecase.getNotificationListEntity(
          doctorId: event.doctorId,
          startIndex: event.startIndex,
          lastIndex: event.lastIndex);
      final unreadCount = await notificationUsecase
          .getUnreadCountNotificationEntity(event.doctorId);
      List<NotificationEntity> newNotificationList =
          state.viewModel.notificationEntity ?? [];
      newNotificationList.addAll(response!);
      final newViewModel = state.viewModel.copyWith(
          notificationEntity: newNotificationList, unreadCount: unreadCount);
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
      emit(SetReadedNotificationState(
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
  }

  Future<void> _deleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      DeleteNotificationState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await notificationUsecase.deleteNotificationEntity(event.notificationId);
      emit(DeleteNotificationState(
          status: BlocStatusState.success, viewModel: state.viewModel));
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
