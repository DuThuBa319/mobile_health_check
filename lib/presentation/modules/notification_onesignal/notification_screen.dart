import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/notification_onesignal/widget/notification_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language_constant.dart';
import '../../../domain/entities/blood_pressure_entity.dart';
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
    // Future.delayed(const Duration(milliseconds: 500)).then((value) async {
    //   // Navigator.pushNamed(context, RouteList.OCR_screen);
    //   final NotificationUsecase count = getIt<NotificationUsecase>();
    //   final unreadCount = await count
    //       .getUnreadCountNotificationEntity(userDataData.getUser()!.id);
    //   notificationData.saveUnreadNotificationCount(unreadCount ?? 0);
    // });
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();
      event.notification.display();
      notificationBloc.add(GetNotificationListEvent(doctorId: widget.id));
      // Navigator.pushNamed(context, RouteList.OCR_screen);
      // final NotificationUsecase count = getIt<NotificationUsecase>();
      // final unreadCount = await count
      //     .getUnreadCountNotificationEntity(userDataData.getUser()!.id);
      // notificationData.saveUnreadNotificationCount(unreadCount ?? 0);
    });
    OneSignal.Notifications.addClickListener((openedResult) {
      //Hàm phía dưới thể hiện số lượng unread còn lại sau khi nhấn pop-up
      // await notificationData.decreaseUnreadNotificationCount();
      // notificationBloc
      //     .add(GetNotificationListEvent(doctorId: userDataData.getUser()!.id));
      notificationBloc.add(
        SetReadedNotificationEvent(
          notificationId: openedResult.notification.notificationId,
        ),
      );
      // debugPrint(openedResult.notification.notificationId);

      // debugPrint(openedResult.notification.additionalData?["Systolic"]);

      // debugPrint(
      //     "#####${openedResult.notification.additionalData?["PulseRate"]}");
      // debugPrint(
      //     "#####${openedResult.notification.additionalData?["Diastolic"]}");
      // debugPrint(
      //     "#####${openedResult.notification.additionalData?["ImageLink"]}");
      // debugPrint(
      //     "#####${openedResult.notification.additionalData?["UpdatedDate"]}");
      if (openedResult.notification.additionalData?["Indicator"] ==
          "BloodPressure") {
        int? sys =
            int.parse(openedResult.notification.additionalData?["Systolic"]);
        int? dia =
            int.parse(openedResult.notification.additionalData?["Diastolic"]);
        int? pulse =
            int.parse(openedResult.notification.additionalData?["PulseRate"]);

        // DateTime? updatedDate = DateTime.parse(
        //     openedResult.notification.additionalData?["UpdatedDate"]);
        Navigator.pushNamed(context, RouteList.bloodPressuerDetail,
            arguments: BloodPressureEntity(
              imageLink: openedResult.notification.additionalData?["ImageLink"],
              // updatedDate: updatedDate,
              sys: sys,
              dia: dia,
              pulse: pulse,
            ));
      }
      if (openedResult.notification.additionalData?["Indicator"] ==
          "BodyTemperature") {
        double? temperature = double.parse(
            openedResult.notification.additionalData?["BodyTemperature"]);

        // DateTime? updatedDate = DateTime.parse(
        //     openedResult.notification.additionalData?["UpdatedDate"]);
        Navigator.pushNamed(context, RouteList.bodyTemperatureDetail,
            arguments: TemperatureEntity(
                imageLink:
                    openedResult.notification.additionalData?["ImageLink"],
                // updatedDate: updatedDate,
                temperature: temperature));
      }

      //!PUT GIẢM SỐ UNREAD COUNT SAU KHI NHẤN VÀO POPUP (lọc theo notificationId)
      // ignore: use_build_context_synchronously

      // ignore: use_build_context_synchronously
      // Navigator.pushNamed(context, RouteList.patientInfor,
      //     arguments: openedResult.notification.additionalData?["patientId"]);
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
        child: Container(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<NotificationBloc, NotificationState>(
              listener: _blocListener,
              builder: (context, state) {
                if (state is NotificationInitialState) {
                  notificationBloc.add(GetNotificationListEvent(
                      doctorId: widget.id ?? widget.id!));
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    "${translation(context).unreadNotifications}:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenWidth * 0.06),
                              ),
                              TextSpan(
                                  text: " ${state.viewModel.unreadCount}",
                                  style: AppTextTheme.body1.copyWith(
                                      color: AppColor.redFB4B53,
                                      fontSize: SizeConfig.screenWidth * 0.08,
                                      fontWeight: FontWeight.w500)),
                            ])),
                        const SizedBox(
                          height: 2,
                        ),
                        lineDecor(),
                        Expanded(
                          child: SmartRefresher(
                              controller: _refreshController,
                              header: const WaterDropHeader(),
                              onRefresh: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 1000));
                                _refreshController.refreshCompleted();
                                notificationBloc.add(GetNotificationListEvent(
                                    doctorId: widget.id ?? widget.id!));
                              },
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount:
                                    state.viewModel.notificationEntity?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final notificationEntity = state
                                      .viewModel.notificationEntity![index];
                                  return NotificationCell(
                                    notificationEntity: notificationEntity,
                                    notificationBloc: notificationBloc,
                                  );
                                },
                              )),
                        ),
                      ],
                    );
                  }
                }

                return Container();
              }),
        ));
  }
}
