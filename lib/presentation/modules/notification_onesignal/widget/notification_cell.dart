import 'package:flutter/material.dart';
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

  final String? doctorId;
  // final DoctorInforEntity? doctorInforEntity;
  const NotificationCell({
    Key? key,
    // this.doctorInforEntity,
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
        if (
          widget.notificationEntity?.read == false) {
          widget.notificationBloc!.add(
            SetReadedNotificationEvent(
              notificationId: widget.notificationEntity?.notificaitonId,
            ),
          );
        }
       
        if (widget.notificationEntity?.bloodPressureEntity != null) {
          showToast(translation(context).waitForSeconds);
          Navigator.pushNamed(context, RouteList.bloodPressuerDetail,
              arguments: widget.notificationEntity?.bloodPressureEntity);
        }
        if (widget.notificationEntity?.bloodSugarEntity != null) {
          showToast(translation(context).waitForSeconds);

          Navigator.pushNamed(context, RouteList.bloodSugarDetail,
              arguments: widget.notificationEntity?.bloodSugarEntity);
        }
        if (widget.notificationEntity?.bodyTemperatureEntity != null) {
          showToast(translation(context).waitForSeconds);
          Navigator.pushNamed(context, RouteList.bodyTemperatureDetail,
              arguments: widget.notificationEntity?.bodyTemperatureEntity);
        } 
         if (widget.notificationEntity?.spo2Entity != null) {
          showToast(translation(context).waitForSeconds);
          Navigator.pushNamed(context, RouteList.spo2Detail,
              arguments: widget.notificationEntity?.spo2Entity);
        }
      },
      child: Container(
          margin: EdgeInsets.only(
              bottom: SizeConfig.screenWidth * 0.02,
              top: SizeConfig.screenWidth * 0.025),
          height: SizeConfig.screenHeight * 0.15,
          width: SizeConfig.screenWidth * 0.8,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin:
                        EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.05),
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                    height: SizeConfig.screenHeight * 0.04,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      color: (widget.notificationEntity?.read == false)
                          ? AppColor.topGradient
                          : AppColor.lightGrey,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.01,
                            ),
                            Text("${widget.notificationEntity?.patientName}",
                                style: AppTextTheme.body3.copyWith(
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                DateFormat('HH:mm dd/MM/yyyy').format((widget
                                    .notificationEntity?.sendDate!
                                    .add(const Duration(hours: 7)))!),
                                style: AppTextTheme.body4.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.screenWidth * 0.035,
                                )),
                            (widget.notificationEntity?.read == true)
                                ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Center(
                                          child: AlertDialog(
                                            title: Text(translation(context)
                                                .notification),
                                            content: Text(
                                              "Delete this notification?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                    translation(context).exit),
                                                onPressed: () {
                                                  //Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text(translation(context)
                                                    .accept),
                                                onPressed: () {
                                                  widget.notificationBloc?.add(
                                                      DeleteNotificationEvent(
                                                          notificationId: widget
                                                              .notificationEntity
                                                              ?.notificaitonId));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete_outlined,
                                      size: SizeConfig.screenWidth * 0.06,
                                      color: AppColor.black,
                                    ))
                                : const SizedBox(
                                    height: 1,
                                    width: 1,
                                  )
                          ],
                        ),
                      ],
                    )),

                Container(
                  width: SizeConfig.screenWidth * 0.92,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    widget.notificationEntity?.content ?? "",
                    style: AppTextTheme.body4.copyWith(
                      wordSpacing: 1,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.screenWidth * 0.045,
                      color: (widget.notificationEntity?.read == false)
                          ? Colors.black
                          : const Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                ),

                // SizedBox(
                //     width: SizeConfig.screenWidth * 0.7,
                //     height: SizeConfig.screenWidth * 0.3,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Text("SYS",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.05,
                //                     fontWeight: FontWeight.w500)),
                //             Text("120",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.085,
                //                     fontWeight: FontWeight.bold,
                //                     color: const Color(0xff424242))),
                //             Text("mmHg",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.03,
                //                     fontWeight: FontWeight.bold,
                //                     color: const Color(0xff888282)))
                //           ],
                //         ),
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Container(
                //               margin: EdgeInsets.only(
                //                   top: SizeConfig.screenWidth * 0.025,
                //                   bottom: SizeConfig.screenWidth * 0.025),
                //               width: SizeConfig.screenWidth * 0.2,
                //               height: SizeConfig.screenWidth * 0.05,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(3),
                //                 color: const Color.fromARGB(255, 255, 210, 186),
                //               ),
                //               child: Center(
                //                 child: Text(indicator,
                //                     style: AppTextTheme.body3.copyWith(
                //                         fontSize: SizeConfig.screenWidth * 0.03,
                //                         fontWeight: FontWeight.bold)),
                //               ),
                //             ),
                //             Text("DIA",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.05,
                //                     fontWeight: FontWeight.w500)),
                //             Text("78",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.085,
                //                     fontWeight: FontWeight.bold,
                //                     color: const Color(0xff424242))),
                //             Text("mmHg",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.03,
                //                     fontWeight: FontWeight.bold,
                //                     color: const Color(0xff888282)))
                //           ],
                //         ),
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Text("PUL",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.05,
                //                     fontWeight: FontWeight.w500)),
                //             Text("80",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.085,
                //                     fontWeight: FontWeight.bold,
                //                     color: const Color(0xff424242))),
                //             Text("bpm",
                //                 style: AppTextTheme.body3.copyWith(
                //                     fontSize: SizeConfig.screenWidth * 0.03,
                //                     fontWeight: FontWeight.bold,
                //                     color: const Color(0xff888282)))
                //           ],
                //         )
                //       ],
                //     ))
              ])),
    );
  }
}
