import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/classes/language.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../domain/entities/notificaion_onesignal_entity.dart';

import '../../../../domain/network/network_info.dart';

import '../../../common_widget/common.dart';
part 'notification_event.dart';
part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUsecase notificationUsecase;
  final NetworkInfo networkInfo;

  NotificationBloc(this.notificationUsecase, this.networkInfo)
      : super(NotificationInitialState()) {
    on<InitializeNotificationScreenEvent>(_onInitializeNotificationScreen);
    on<GetNotificationListEvent>(_onGetNotificationList);
    on<SetReadedNotificationEvent>(_setReadedNotification);
    on<SetReadedNotificationFromCellEvent>(_setReadedNotificationFromCell);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<RefreshNotificationListEvent>(_onRefreshNotificationList);
  }
  Future<void> _onInitializeNotificationScreen(
    InitializeNotificationScreenEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (await Permission.notification.status != PermissionStatus.granted) {
      await showWarningDialog(
          context: navigationService.navigatorKey.currentContext!,
          message: translation(navigationService.navigatorKey.currentContext!)
              .permissionNotificationWarning,
          onClose1: () {},
          onClose2: () async {
            await openAppSettings();
          });
    }
  }

  Future<void> _onGetNotificationList(
    GetNotificationListEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        GetNotificationListState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        int? numberOfNotificationEntity = await notificationUsecase
            .getNumberOfNotificationEntity(event.userId);
        int requestLastIndex = 0;
        final unreadCount = await notificationUsecase
            .getUnreadCountNotificationEntity(event.userId);
        numberOfNotificationEntity ??= 0;
        _ViewModel newViewModel = _ViewModel(
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
            userId: event.userId,
            startIndex: event.startIndex,
            lastIndex: requestLastIndex);

        List<NotificationEntity> newNotificationList =
            state.viewModel.notificationEntity ?? [];
        newNotificationList.addAll(response!);

        newViewModel = _ViewModel(
            notificationEntity: newNotificationList,
            unreadCount: unreadCount,
            totalCount: numberOfNotificationEntity);

        emit(GetNotificationListState(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ));
      } catch (e) {
        emit(
          GetNotificationListState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        GetNotificationListState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _onRefreshNotificationList(
    RefreshNotificationListEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        RefreshNotificationListState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        final response = await notificationUsecase.getNotificationListEntity(
            userId: event.userId, startIndex: 0, lastIndex: 14);
        final totalCount = await notificationUsecase
            .getNumberOfNotificationEntity(event.userId);
        final unreadCount = await notificationUsecase
            .getUnreadCountNotificationEntity(event.userId);
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
          RefreshNotificationListState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        RefreshNotificationListState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _setReadedNotification(
    SetReadedNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          SetReadedNotificationState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        SetReadedNotificationState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _setReadedNotificationFromCell(
    SetReadedNotificationFromCellEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
          SetReadedNotificationFromCellState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        SetReadedNotificationFromCellState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }

  Future<void> _deleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        DeleteNotificationState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        await notificationUsecase
            .deleteNotificationEntity(event.notificationId);
        state.viewModel.notificationEntity?.removeAt(event.index!);
        emit(DeleteNotificationState(
            status: BlocStatusState.success,
            viewModel: state.viewModel
                .copyWith(totalCount: state.viewModel.totalCount! - 1)));
      } catch (e) {
        emit(
          DeleteNotificationState(
            status: BlocStatusState.failure,
            viewModel: _ViewModel(
                errorMessage:
                    translation(navigationService.navigatorKey.currentContext!)
                        .error),
          ),
        );
      }
    } else {
      emit(
        DeleteNotificationState(
          status: BlocStatusState.failure,
          viewModel: _ViewModel(
              isWifiDisconnect: true,
              errorMessage:
                  translation(navigationService.navigatorKey.currentContext!)
                      .wifiDisconnect),
        ),
      );
    }
  }
}
