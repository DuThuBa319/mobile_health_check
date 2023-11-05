import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/notificaion_onesignal_entity.dart';
import '../../../../function.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../bloc/notification_bloc.dart';

class NotificationCell extends StatefulWidget {
  final NotificationEntity? notificationEntity;
  final NotificationBloc? notificationBloc;
  final int? cellIndex;
  final String? doctorId;
  // final DoctorInforEntity? doctorInforEntity;
  const NotificationCell({
    Key? key,
    // this.doctorInforEntity,
    this.cellIndex,
    this.doctorId,
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
                  widget.notificationEntity?.read == true
                      ? showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(translation(context).notification),
                              content:
                                  Text(translation(context).deleteNotification),
                              actions: [
                                TextButton(
                                  child: Text(translation(context).exit),
                                  onPressed: () {
                                    //Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text(translation(context).accept),
                                  onPressed: () {
                                    widget.notificationBloc?.add(
                                        DeleteNotificationEvent(
                                            index: widget.cellIndex,
                                            notificationId: widget
                                                .notificationEntity
                                                ?.notificaitonId));
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        )
                      : null;
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
                      height: SizeConfig.screenHeight * 0.05,
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: (widget.notificationEntity?.read == false)
                            ? AppColor.topGradient
                            : AppColor.lightGrey,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${widget.notificationEntity?.patientName}",
                              softWrap: true,
                              style: AppTextTheme.body3.copyWith(
                                  fontSize: SizeConfig.screenWidth * 0.04,
                                  fontWeight: FontWeight.bold)),
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
  switch (notificationEntity.type) {
    case 0:
      return Container(
        width: SizeConfig.screenWidth * 0.92,
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          "${translation(context).patient} ${notificationEntity.patientName} ${translation(context).hasJustUpdated} ${translation(context).bloodPressureIndex}",
          style: AppTextTheme.body4.copyWith(
            wordSpacing: 1,
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.screenWidth * 0.045,
            color: (notificationEntity.read == false)
                ? Colors.black
                : const Color.fromARGB(255, 93, 93, 93),
          ),
          softWrap: true,
        ),
      );
    case 1:
      return Container(
        width: SizeConfig.screenWidth * 0.92,
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          softWrap: true,
          "${translation(context).patient} ${notificationEntity.patientName} ${translation(context).hasJustUpdated} ${translation(context).bloodSugarIndex}",
          style: AppTextTheme.body4.copyWith(
            wordSpacing: 1,
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.screenWidth * 0.045,
            color: (notificationEntity.read == false)
                ? Colors.black
                : const Color.fromARGB(255, 93, 93, 93),
          ),
        ),
      );
    case 2:
      return Container(
        width: SizeConfig.screenWidth * 0.92,
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          softWrap: true,
          "${translation(context).patient} ${notificationEntity.patientName} ${translation(context).hasJustUpdated} ${translation(context).bodyTemperatureIndex}",
          style: AppTextTheme.body4.copyWith(
            wordSpacing: 1,
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.screenWidth * 0.045,
            color: (notificationEntity.read == false)
                ? Colors.black
                : const Color.fromARGB(255, 93, 93, 93),
          ),
        ),
      );
    case 3:
      return Container(
        width: SizeConfig.screenWidth * 0.92,
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          softWrap: true,
          "${translation(context).patient} ${notificationEntity.patientName} ${translation(context).hasJustUpdated} ${translation(context).spo2Index}",
          style: AppTextTheme.body4.copyWith(
            wordSpacing: 1,
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.screenWidth * 0.045,
            color: (notificationEntity.read == false)
                ? Colors.black
                : const Color.fromARGB(255, 93, 93, 93),
          ),
        ),
      );
    default:
      return Container(
        width: SizeConfig.screenWidth * 0.92,
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          "",
          style: AppTextTheme.body4.copyWith(
            wordSpacing: 1,
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.screenWidth * 0.045,
            color: (notificationEntity.read == false)
                ? Colors.black
                : const Color.fromARGB(255, 93, 93, 93),
          ),
        ),
      );
  }
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