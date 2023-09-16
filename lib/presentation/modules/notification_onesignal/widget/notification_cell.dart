import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/notificaion_onesignal_entity.dart';
import '../../../../function.dart';
import '../../../route/route_list.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';
import '../bloc/notification_bloc.dart';

class NotificationCell extends StatefulWidget {
  final NotificationEntity? notificationEntity;
  final NotificationBloc? notificationBloc;

  // final DoctorInforEntity? doctorInforEntity;
  const NotificationCell({
    Key? key,
    // this.doctorInforEntity,

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
      onTap: () async {
        if (widget.notificationEntity?.read == false) {
          // OneSignal.shared.removeNotification();
          // await notificationData.decreaseUnreadNotificationCount();
          widget.notificationBloc!.add(
            SetReadedNotificationEvent(
              notificationId: widget.notificationEntity?.notificaitonId,
            ),
          );
        }
        //  await notificationData
        // .saveNotificationId1(widget.notificationEntity?.notificaitonId??"");

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RouteList.patientInfor,
            arguments: widget.notificationEntity?.patientId);
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.notificationEntity?.patientName}",
                                    style: AppTextTheme.body3.copyWith(
                                        fontSize: SizeConfig.screenWidth * 0.04,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                        Text(
                            DateFormat('HH:mm dd/MM/yyyy').format((widget
                                .notificationEntity?.sendDate!
                                .add(const Duration(hours: 7)))!),
                            style: AppTextTheme.body4.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.screenWidth * 0.035,
                            )),
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
                )
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
