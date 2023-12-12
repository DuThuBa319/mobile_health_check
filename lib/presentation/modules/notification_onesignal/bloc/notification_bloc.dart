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
    on<SetReadedNotificationFromCellEvent>(_setReadedNotificationFromCell);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<RefreshNotificationListEvent>(_onRefreshNotificationList);
    on<RenewPageAfterActionEvent>(_onRenewPageAfterAction);
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
      int? numberOfNotificationEntity = await notificationUsecase
          .getNumberOfNotificationEntity(event.doctorId);
      int requestLastIndex = 0;
      final unreadCount = await notificationUsecase
          .getUnreadCountNotificationEntity(event.doctorId);
      numberOfNotificationEntity ??= 0;

      _ViewModel newViewModel = state.viewModel.copyWith(
          unreadCount: unreadCount,
          totalCount: numberOfNotificationEntity,
          notificationEntity: []);

      if (numberOfNotificationEntity == 0) {
        emit(GetNotificationListState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ));
        return;
      }
      
      if (numberOfNotificationEntity <= event.lastIndex) {
        requestLastIndex = numberOfNotificationEntity - 1;
      } else {
        requestLastIndex = event.lastIndex;
      }
      final response = await notificationUsecase.getNotificationListEntity(
          userId: event.doctorId,
          startIndex: event.startIndex,
          lastIndex: requestLastIndex);

      List<NotificationEntity> newNotificationList =
          state.viewModel.notificationEntity ?? [];
      newNotificationList.addAll(response!);

      newViewModel = state.viewModel.copyWith(
          notificationEntity: newNotificationList,
          unreadCount: unreadCount,
          totalCount: numberOfNotificationEntity);

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

  Future<void> _onRenewPageAfterAction(
    RenewPageAfterActionEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      RenewPageAfterActionState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await notificationUsecase.getNotificationListEntity(
          userId: event.doctorId,
          startIndex: event.startIndex,
          lastIndex: event.lastIndex);

      final unreadCount = await notificationUsecase
          .getUnreadCountNotificationEntity(event.doctorId);
      final totalCount = await notificationUsecase
          .getNumberOfNotificationEntity(event.doctorId);
      final newViewModel = state.viewModel.copyWith(
          notificationEntity: response,
          unreadCount: unreadCount,
          totalCount: totalCount);
      emit(RenewPageAfterActionState(
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

  Future<void> _onRefreshNotificationList(
    RefreshNotificationListEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      RefreshNotificationListState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response = await notificationUsecase.getNotificationListEntity(
          userId: event.doctorId, startIndex: 0, lastIndex: 14);
      final totalCount = await notificationUsecase
          .getNumberOfNotificationEntity(event.doctorId);
      final unreadCount = await notificationUsecase
          .getUnreadCountNotificationEntity(event.doctorId);
      final newViewModel = state.viewModel.copyWith(
          notificationEntity: response,
          unreadCount: unreadCount,
          totalCount: totalCount);
      emit(RefreshNotificationListState(
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

  Future<void> _setReadedNotificationFromCell(
    SetReadedNotificationFromCellEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      SetReadedNotificationFromCellState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      await notificationUsecase
          .setReadedNotificationEntity(event.notificationId);
      state.viewModel.notificationEntity?.elementAt(event.index!).read = true;
      emit(SetReadedNotificationFromCellState(
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
      state.viewModel.notificationEntity?.removeAt(event.index!);
      emit(DeleteNotificationState(
          status: BlocStatusState.success,
          viewModel: state.viewModel
              .copyWith(totalCount: state.viewModel.totalCount! - 1)));
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
