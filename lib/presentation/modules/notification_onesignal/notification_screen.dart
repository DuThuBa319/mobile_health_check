import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/notification_onesignal/widget/notification_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language_constant.dart';
import '../../../common/singletons.dart';
import '../../../di/di.dart';
import '../../../domain/usecases/notification_onesignal_usecase/notification_onesignal_usecase.dart';
import '../../../presentation/common_widget/screen_form/custom_screen_form.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/loading_widget.dart';
import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
import 'bloc/notification_bloc.dart';
part 'notification_screen_action.dart';

//Class Home
class NotificationScreen extends StatefulWidget {
  final String? id;

  const NotificationScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  NotificationBloc get notificationBloc => BlocProvider.of(context);
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      // Navigator.pushNamed(context, RouteList.OCR_screen);
      final NotificationUsecase count = getIt<NotificationUsecase>();
      final unreadCount = await count
          .getUnreadCountNotificationEntity(userDataData.getUser()!.id);
      notificationData.saveUnreadNotificationCount(unreadCount ?? 0);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) async {
      // await notificationData
      //     .saveNotificationId1(event.notification.notificationId);

      // Navigator.pushNamed(context, RouteList.OCR_screen);
      final NotificationUsecase count = getIt<NotificationUsecase>();
      final unreadCount = await count
          .getUnreadCountNotificationEntity(userDataData.getUser()!.id);
      notificationData.saveUnreadNotificationCount(unreadCount ?? 0);
      setState(() {});

      // _inAppNotificationController.add(
      //   NotificationModel.fromJson(event.notification.additionalData ?? {}),
      // );
      // LogUtils.d(
      //   'Onesignal ShowInForeground ${event.notification.additionalData}',
      // );
      // await notificationData.increaseUnreadNotificationCount();
      // widget.notificationBloc
      //     ?.add(IncreaseNotificationEvent(count: notificationData.unreadCount));
      debugPrint('###${notificationData.unreadCount}');
      event.complete(event.notification);
    });

    OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
      //Hàm phía dưới thể hiện số lượng unread còn lại sau khi nhấn pop-up
      // await notificationData.decreaseUnreadNotificationCount();

      final NotificationUsecase notificationUsecase =
          getIt<NotificationUsecase>();
      await notificationUsecase.setReadedNotificationEntity(
          openedResult.notification.notificationId);
      //!PUT GIẢM SỐ UNREAD COUNT SAU KHI NHẤN VÀO POPUP (lọc theo notificationId)
      // final unreadCount = await notificationUsecase
      //     .getUnreadCountNotificationEntity(userDataData.getUser()!.id);
      // await notificationData.saveUnreadNotificationCount(unreadCount!);
      // final data = openedResult.notification.body;
      // print("xxxxxxxaaaa$data");
      // widget.notificationBloc
      //     ?.add(DecreaseNotificationEvent(count: notificationData.unreadCount));
      Future.delayed(const Duration(milliseconds: 500));
      print('###${notificationData.unreadCount}');

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, RouteList.patientInfor,
          arguments: openedResult.notification.additionalData?["patientId"]);
      setState(() {});
    });
    SizeConfig.init(context);
    return CustomScreenForm(
        isShowAppBar: true,
        isShowLeadingButton: true,
        isShowBottomNayvigationBar: true,
        isShowRightButon: false,
        backgroundColor: AppColor.white,
        appBarColor: AppColor.topGradient,

        // rightButton: IconButton(
        //   onPressed: gotoRegistnotificationScreen,
        //   icon: const Icon(Icons.add),
        title: translation(context).notification,
        // ),
        selectedIndex: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "${translation(context).unreadNotifications}:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.screenWidth * 0.06),
                    ),
                    TextSpan(
                        text: " ${notificationData.unreadCount}",
                        style: AppTextTheme.body1.copyWith(
                            color: AppColor.redFB4B53,
                            fontSize: SizeConfig.screenWidth * 0.08,
                            fontWeight: FontWeight.w500)),
                  ])),
              const SizedBox(
                height: 2,
              ),
              lineDecor(),
              BlocConsumer<NotificationBloc, NotificationState>(
                  listener: _blocListener,
                  builder: (context, state) {
                    if (state is NotificationInitialState) {
                      notificationBloc.add(GetNotificationListEvent(
                          id: widget.id ?? widget.id!));
                    }
                    if (state is GetNotificationListState &&
                        state.status == BlocStatusState.loading) {
                      return const Expanded(
                        child: Center(
                          child: Loading(brightness: Brightness.light),
                        ),
                      );
                    }

                    if (state is GetNotificationListState &&
                        state.status == BlocStatusState.success) {
                      if (state.viewModel.notificationEntity!.isEmpty) {
                        return Center(
                            child: Text(translation(context).selectTime,
                                style: AppTextTheme.body2
                                    .copyWith(color: Colors.red)));
                      } else {
                        return Expanded(
                          child: SmartRefresher(
                            controller: _refreshController,
                            header: const WaterDropHeader(),
                            onRefresh: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              _refreshController.refreshCompleted();
                              notificationBloc.add(GetNotificationListEvent(
                                  id: widget.id ?? widget.id!));
                            },
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount:
                                  state.viewModel.notificationEntity?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final notificationEntity =
                                    state.viewModel.notificationEntity![index];
                                return NotificationCell(
                                  notificationEntity: notificationEntity,
                                  notificationBloc: notificationBloc,
                                );
                              },
                            ),
                          ),
                        );
                      }
                    }
                    return Container();
                  }),
            ],
          ),
        ));
  }
}
