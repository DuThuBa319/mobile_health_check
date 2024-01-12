import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/notificaion_onesignal_entity.dart';
import '../../../../utils/size_config.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../bloc/notification_bloc.dart';

class NotificationCell extends StatefulWidget {
  final NotificationEntity? notificationEntity;
  final NotificationBloc? notificationBloc;
  final int? cellIndex;
  final String? userId;
  // final DoctorInforEntity? doctorInforEntity;
  const NotificationCell({
    Key? key,
    // this.doctorInforEntity,
    this.cellIndex,
    this.userId,
    this.notificationBloc,
    this.notificationEntity,
  }) : super(key: key);

  @override
  State<NotificationCell> createState() => _NotificationCellState();
}

class _NotificationCellState extends State<NotificationCell> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      onTap: () {
        if (widget.notificationEntity?.read == false) {
          widget.notificationBloc!.add(
            SetReadedNotificationFromCellEvent(
              index: widget.cellIndex,
              notificationId: widget.notificationEntity?.notificaitonId,
            ),
          );
        }

        if (widget.notificationEntity?.bloodPressureEntity != null) {
          showToast(translation(context).waitForSeconds);
          Navigator.pushNamed(
              context, RouteList.bloodPressuerNotificationReading, arguments: {
            "notificationEntity": widget.notificationEntity,
            "navigateFromCell": true
          });
        }
        if (widget.notificationEntity?.bloodSugarEntity != null) {
          showToast(translation(context).waitForSeconds);

          Navigator.pushNamed(context, RouteList.bloodSugarNotificationReading,
              arguments: {
                "notificationEntity": widget.notificationEntity,
                "navigateFromCell": true
              });
        }
        if (widget.notificationEntity?.bodyTemperatureEntity != null) {
          showToast(translation(context).waitForSeconds);
          Navigator.pushNamed(
              context, RouteList.bodyTemperatureNotificationReading,
              arguments: {
                "notificationEntity": widget.notificationEntity,
                "navigateFromCell": true
              });
        }
        if (widget.notificationEntity?.spo2Entity != null) {
          showToast(translation(context).waitForSeconds);
          Navigator.pushNamed(context, RouteList.spo2NotificationReading,
              arguments: {
                "notificationEntity": widget.notificationEntity,
                "navigateFromCell": true
              });
        }
      },
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                label: translation(context).delete,
                autoClose: true,
                borderRadius: BorderRadius.circular(10),
                onPressed: (context) {
                  if (widget.notificationEntity?.read == true) {
                    widget.notificationBloc?.add(DeleteNotificationEvent(
                        index: widget.cellIndex,
                        notificationId:
                            widget.notificationEntity?.notificaitonId));
                  }
                },
                backgroundColor: (widget.notificationEntity?.read == true)
                    ? AppColor.lineDecor
                    : AppColor.lightGrey,
                foregroundColor: Colors.white,
                icon: Icons.delete_outline_outlined,
              ),
            ]),
        child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.15,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black12,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                    color: (widget.notificationEntity?.read == false)
                        ? AppColor.topGradient
                        : AppColor.lightGrey,
                    width: 3)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: (SizeConfig.screenWidth - 5),
                      height: SizeConfig.screenHeight * 0.04,
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: (widget.notificationEntity?.read == false)
                            ? AppColor.topGradient
                            : AppColor.lightGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.white),
                                child: const Icon(
                                    Icons.circle_notifications_sharp,
                                    color: AppColor.lineDecor),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.02,
                              ),
                              Text(
                                  widget.notificationEntity?.type == 0
                                      ? translation(context).updateBloodPressure
                                      : widget.notificationEntity?.type == 1
                                          ? translation(context)
                                              .updateBloodSugar
                                          : widget.notificationEntity?.type == 2
                                              ? translation(context)
                                                  .updateBodytemperature
                                              : widget.notificationEntity
                                                          ?.type ==
                                                      3
                                                  ? translation(context)
                                                      .updateSpo2
                                                  : "",
                                  softWrap: true,
                                  style: AppTextTheme.body3.copyWith(
                                      color: AppColor.black,
                                      fontSize: SizeConfig.screenWidth * 0.04,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Text(
                              softWrap: true,
                              DateFormat('HH:mm dd/MM/yyyy').format((widget
                                  .notificationEntity?.sendDate!
                                  .add(const Duration(hours: 7)))!),
                              style: AppTextTheme.body4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.screenWidth * 0.03,
                              )),
                        ],
                      )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      contentCell(widget.notificationEntity!, context),
                    ],
                  ))
                ])),
      ),
    );
  }
}

Widget contentCell(
    NotificationEntity notificationEntity, BuildContext context) {
  return Container(
      width: SizeConfig.screenWidth * 0.92,
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: RichText(
        softWrap: true,
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
                text: translation(context).patient,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: SizeConfig.screenWidth * 0.045,
                )),
            const WidgetSpan(
                child: SizedBox(
              width: 5,
            )),
            TextSpan(
              text: notificationEntity.patientName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.screenWidth * 0.048,
                  fontWeight: FontWeight.bold),
            ),
            const WidgetSpan(
                child: SizedBox(
              width: 5,
            )),
            TextSpan(
              text: translation(context).hasJustUpdated,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.screenWidth * 0.045),
            ),
            const WidgetSpan(
                child: SizedBox(
              width: 5,
            )),
            TextSpan(
              text: notificationEntity.type == 0
                  ? translation(context).bloodPressureIndex
                  : notificationEntity.type == 1
                      ? translation(context).bloodSugarIndex
                      : notificationEntity.type == 2
                          ? translation(context).bodyTemperatureIndex
                          : notificationEntity.type == 3
                              ? translation(context).spo2Index
                              : "",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.screenWidth * 0.048,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ));
}

//  showNoticeDialogTwoButton(
//                                             context: context,
//                                             message: translation(context)
//                                                 .deleteNotification,
//                                             title:
//                                                 translation(context).notification,
//                                             titleBtn1: translation(context).exit,
//                                             titleBtn2:
//                                                 translation(context).accept,
//                                             onClose1: () =>
//                                                 Navigator.pop(context),
//                                             onClose2: () => widget
//                                                 .notificationBloc
//                                                 ?.add(DeleteNotificationEvent(
//                                                     index: widget.cellIndex,
//                                                     notificationId: widget
//                                                         .notificationEntity
//                                                         ?.notificaitonId)));