import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/notificaion_onesignal_entity.dart';
import 'package:mobile_health_check/presentation/common_widget/common_button.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../function.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';

class BloodPressureNotificationReadingScreen extends StatefulWidget {
  final NotificationEntity? notificationEntity;
  const BloodPressureNotificationReadingScreen(
      {super.key, required this.notificationEntity});

  @override
  State<BloodPressureNotificationReadingScreen> createState() =>
      _BloodPressureNotificationReadingScreenState();
}

class _BloodPressureNotificationReadingScreenState
    extends State<BloodPressureNotificationReadingScreen> {
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(milliseconds: 3000), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

////////////////////////
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, SizeConfig.screenWidth * 0.08, 12, 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffA9E7FF),
              Color(0xffA9E7FF),
              // Colors.white, // Xanh nhạt nhất
              // Xanh đậm nhất
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Thay đổi begin và end để điều chỉnh hướng chuyển đổi màu
          ),
        ),
        child: DefaultTextStyle(
          style: AppTextTheme.body2,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenWidth * 0.1,
              ),
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.notificationEntity?.patientName}",
                        style: AppTextTheme.body1.copyWith(
                            fontSize: SizeConfig.screenWidth * 0.07,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        " ${DateFormat('HH:mm').format(widget.notificationEntity?.sendDate ?? DateTime(2023, 9, 16, 12, 00))}  ${DateFormat('dd/MM/yyyy').format(widget.notificationEntity?.sendDate ?? DateTime(2023, 9, 16, 12, 00))}",
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.055),
                      ),
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenWidth * 0.06,
              ),
              CustomImagePicker(
                imagePath: widget
                        .notificationEntity?.bloodPressureEntity?.imageLink ??
                    widget.notificationEntity?.bloodPressureEntity?.imageLink!,
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenWidth * 0.06,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.245,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('SYS',
                                  style: AppTextTheme.title2.copyWith(
                                      fontSize: 24, color: Colors.black)),
                              const SizedBox(height: 5),
                              Text(
                                'mmHg',
                                style:
                                    AppTextTheme.title5.copyWith(fontSize: 15),
                              ),
                              SizedBox(height: SizeConfig.screenWidth * 0.04),
                              Text(
                                  "${widget.notificationEntity?.bloodPressureEntity!.sys}",
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget.notificationEntity
                                          ?.bloodPressureEntity!.statusColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: SizeConfig.screenWidth * 0.1)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('PUL',
                                  style: AppTextTheme.title2.copyWith(
                                      fontSize: 24, color: Colors.black)),
                              const SizedBox(height: 5),
                              Text(
                                'bpm',
                                style:
                                    AppTextTheme.title5.copyWith(fontSize: 15),
                              ),
                              SizedBox(height: SizeConfig.screenWidth * 0.04),
                              Text(
                                  "${widget.notificationEntity?.bloodPressureEntity!.pulse}",
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget.notificationEntity
                                          ?.bloodPressureEntity!.statusColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: SizeConfig.screenWidth * 0.1)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenWidth * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.favorite,
                              color: widget.notificationEntity
                                  ?.bloodPressureEntity!.statusColor),
                          Container(
                              decoration: BoxDecoration(
                                  color: widget.notificationEntity
                                      ?.bloodPressureEntity!.statusColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 8,
                              width: SizeConfig.screenWidth * 0.72),
                          Icon(Icons.favorite,
                              color: widget.notificationEntity
                                  ?.bloodPressureEntity!.statusColor),
                        ],
                      ),
                      Text(
                          // ignore: unrelated_type_equality_checks
                          "${widget.notificationEntity?.bloodPressureEntity!.statusComment(context)}",
                          style: AppTextTheme.body2.copyWith(
                              color: widget.notificationEntity
                                  ?.bloodPressureEntity!.statusColor,
                              fontWeight: FontWeight.w700)),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenWidth * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonButton(
                    editSizeText: true,
                    sizeText: SizeConfig.screenWidth * 0.04,
                    height: SizeConfig.screenHeight * 0.07,
                    width: SizeConfig.screenWidth * 0.45,
                    title: translation(context).goToPatientIn4Screen,
                    buttonColor: Colors.red,
                    onTap: () {
                      // if (_isLoading == false) {

                      Navigator.pushNamed(context, RouteList.patientInfor,
                          arguments: widget.notificationEntity?.patientId);
                      // }
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CommonButton(
                    editSizeText: true,
                    sizeText: SizeConfig.screenWidth * 0.04,
                    height: SizeConfig.screenHeight * 0.07,
                    width: SizeConfig.screenWidth * 0.45,
                    title: translation(context).goToNotificationScreen,
                    buttonColor: Colors.red,
                    onTap: () {
                      Navigator.pushNamed(context, RouteList.notification,arguments: userDataData.getUser()?.id);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
