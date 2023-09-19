import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/domain/entities/blood_sugar_entity.dart';
import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/modules/notification_onesignal/widget/notification_cell.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language_constant.dart';
import '../../../domain/entities/blood_pressure_entity.dart';
import '../../../domain/entities/temperature_entity.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();
      event.notification.display();
      // notificationBloc.add(GetNotificationListEvent(doctorId: widget.id));
    });

    OneSignal.Notifications.addClickListener((openedResult) {
      if (openedResult.notification.additionalData?["Indicator"] ==
          "BloodPressure") {
        notificationBloc.add(
          SetReadedNotificationEvent(
            notificationId: openedResult.notification.notificationId,
          ),
        );

        int? sys =
            int.parse(openedResult.notification.additionalData?["Systolic"]);
        int? dia =
            int.parse(openedResult.notification.additionalData?["Diastolic"]);
        int? pulse =
            int.parse(openedResult.notification.additionalData?["PulseRate"]);
        String dateString =
            openedResult.notification.additionalData?["UpdatedDate"];
        DateTime updatedDate =
            DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
        final BloodPressureEntity bloodPressureEntity = BloodPressureEntity(
          imageLink: openedResult.notification.additionalData?["ImageLink"],
          updatedDate: updatedDate,
          sys: sys,
          pulse: pulse,
        );
        showToast(translation(context).waitForSeconds);

        Navigator.pushNamed(context, RouteList.bloodPressuerDetail,
            arguments: bloodPressureEntity);
      }
      if (openedResult.notification.additionalData?["Indicator"] ==
          "BodyTemperature") {
        String dateString =
            openedResult.notification.additionalData?["UpdatedDate"];
        DateTime updatedDate =
            DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
        notificationBloc.add(
          SetReadedNotificationEvent(
            notificationId: openedResult.notification.notificationId,
          ),
        );
        double? value = double.parse(
            openedResult.notification.additionalData?["BodyTemperature"]);
        debugPrint("$value");

        final TemperatureEntity temperatureEntity = TemperatureEntity(
          imageLink: openedResult.notification.additionalData?["ImageLink"],
          temperature: value,
          updatedDate: updatedDate,
        );
        showToast(translation(context).waitForSeconds);

        Navigator.pushNamed(context, RouteList.bodyTemperatureDetail,
            arguments: temperatureEntity);
      }

      if (openedResult.notification.additionalData?["Indicator"] ==
          "BloodSugar") {
        String dateString =
            openedResult.notification.additionalData?["UpdatedDate"];
        DateTime updatedDate =
            DateFormat('M/d/yyyy h:mm:ss a').parse(dateString);
        notificationBloc.add(
          SetReadedNotificationEvent(
            notificationId: openedResult.notification.notificationId,
          ),
        );
        double? value = double.parse(
            openedResult.notification.additionalData?["BloodSugar"]);
        debugPrint("$value");

        final BloodSugarEntity bloodSugarEntity = BloodSugarEntity(
          imageLink: openedResult.notification.additionalData?["ImageLink"],
          bloodSugar: value,
          updatedDate: updatedDate,
        );
        showToast(translation(context).waitForSeconds);

        Navigator.pushNamed(context, RouteList.bloodSugarDetail,
            arguments: bloodSugarEntity);

        // Navigator.pushNamed(context, RouteList.patientInfor,
        //     arguments: openedResult.notification.additionalData?["patientId"]);
      }
      //!PUT GIẢM SỐ UNREAD COUNT SAU KHI NHẤN VÀO POPUP (lọc theo notificationId)
      // ignore: use_build_context_synchronously

      // ignore: use_build_context_synchronously
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
                      doctorId: widget.id ?? widget.id!, startIndex: 0,
                                    lastIndex: 25));
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
                                    doctorId: widget.id ?? widget.id!,
                                    startIndex: 0,
                                    lastIndex: 25));
                              },
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: 20,
                                    // state.viewModel.notificationEntity?.length,
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
