import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/notificaion_onesignal_entity.dart';
import 'package:mobile_health_check/presentation/route/route_list.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../utils/size_config.dart';
import '../../../common_widget/common.dart';

class BloodPressureNotificationReadingScreen extends StatefulWidget {
  final NotificationEntity? notificationEntity;
  final bool? navigateFromCell;
  const BloodPressureNotificationReadingScreen(
      {super.key,
      required this.navigateFromCell,
      required this.notificationEntity});

  @override
  State<BloodPressureNotificationReadingScreen> createState() =>
      _BloodPressureNotificationReadingScreenState();
}

class _BloodPressureNotificationReadingScreenState
    extends State<BloodPressureNotificationReadingScreen> {
  bool isWifiAvailable = false;
  bool is4GAvailable = false;
  @override
  void initState() {
    super.initState();
    checkWifiAvailability();
  }

  void checkWifiAvailability() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      // ignore: unrelated_type_equality_checks
      isWifiAvailable = connectivityResult == ConnectivityResult.wifi;
      is4GAvailable = connectivityResult == ConnectivityResult.mobile;
    });
  }

////////////////////////
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth * 0.02,
            SizeConfig.screenHeight * 0.04, SizeConfig.screenWidth * 0.02, 0),
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
                height: SizeConfig.screenHeight * 0.015,
              ),
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.01)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.notificationEntity?.patientName}",
                        style: AppTextTheme.body1.copyWith(
                            fontSize: SizeConfig.screenDiagonal * 0.022,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        " ${DateFormat('HH:mm').format(widget.notificationEntity?.sendDate ?? DateTime(2023, 9, 16, 12, 00))}  ${DateFormat('dd/MM/yyyy').format(widget.notificationEntity?.sendDate ?? DateTime(2023, 9, 16, 12, 00))}",
                        style: AppTextTheme.body1.copyWith(
                            fontSize: SizeConfig.screenDiagonal * 0.02),
                      ),
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenHeight * 0.035
                    : SizeConfig.screenHeight * 0.015,
              ),
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.notificationEntity?.bloodPressureEntity
                            ?.imageLink ??
                        ""
                    : null,
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenHeight * 0.035
                    : SizeConfig.screenHeight * 0.015,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.005,
                      right: SizeConfig.screenWidth * 0.005,
                      top: SizeConfig.screenHeight * 0.01),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenDiagonal < 1350
                      ? SizeConfig.screenHeight * 0.26
                      : SizeConfig.screenHeight * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.01)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('SYS',
                                  style: AppTextTheme.title2.copyWith(
                                      fontSize: SizeConfig.screenDiagonal < 1350
                                          ? SizeConfig.screenHeight * 0.03
                                          : SizeConfig.screenHeight * 0.035,
                                      color: Colors.black)),
                              const SizedBox(height: 5),
                              Text(
                                'mmHg',
                                style: AppTextTheme.title5.copyWith(
                                  fontSize: SizeConfig.screenHeight * 0.022,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              Text(
                                  "${widget.notificationEntity?.bloodPressureEntity!.sys}",
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget.notificationEntity
                                          ?.bloodPressureEntity!.statusColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          SizeConfig.screenDiagonal * 0.04)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('PUL',
                                  style: AppTextTheme.title2.copyWith(
                                      fontSize: SizeConfig.screenDiagonal < 1350
                                          ? SizeConfig.screenHeight * 0.03
                                          : SizeConfig.screenHeight * 0.035,
                                      color: Colors.black)),
                              const SizedBox(height: 5),
                              Text(
                                'bpm',
                                style: AppTextTheme.title5.copyWith(
                                  fontSize: SizeConfig.screenHeight * 0.022,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              Text(
                                  "${widget.notificationEntity?.bloodPressureEntity!.pulse}",
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget.notificationEntity
                                          ?.bloodPressureEntity!.statusColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          SizeConfig.screenDiagonal * 0.04)),
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
                                  ?.bloodPressureEntity!.statusColor,
                              size: SizeConfig.screenWidth * 0.035),
                          Container(
                              decoration: BoxDecoration(
                                  color: widget.notificationEntity
                                      ?.bloodPressureEntity!.statusColor,
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.screenWidth * 0.0065)),
                              height: SizeConfig.screenHeight * 0.0065,
                              width: SizeConfig.screenWidth * 0.72),
                          Icon(
                            Icons.favorite,
                            size: SizeConfig.screenWidth * 0.035,
                            color: widget.notificationEntity
                                ?.bloodPressureEntity!.statusColor,
                          ),
                        ],
                      ),
                      Text(
                          softWrap: true,
                          maxLines: 2,
                          // ignore: unrelated_type_equality_checks
                          "${widget.notificationEntity?.bloodPressureEntity!.statusComment(context)}",
                          style: AppTextTheme.body2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.055,
                              color: widget.notificationEntity
                                  ?.bloodPressureEntity!.statusColor,
                              fontWeight: FontWeight.w700)),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RectangleButton(
                    editSizeText: true,
                    sizeText: SizeConfig.screenDiagonal * 0.018,
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
                  RectangleButton(
                    editSizeText: true,
                    sizeText: SizeConfig.screenDiagonal * 0.018,
                    height: SizeConfig.screenHeight * 0.07,
                    width: SizeConfig.screenWidth * 0.45,
                    title: translation(context).goToNotificationScreen,
                    buttonColor: Colors.red,
                    onTap: () {
                      (widget.navigateFromCell == true)
                          ? Navigator.pop(context)
                          : Navigator.pushNamed(context, RouteList.notification,
                              arguments: userDataData.getUser()?.id);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
