import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/domain/entities/notificaion_onesignal_entity.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/common_widget/rectangle_button.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';

class TemperatureNotificationReadingScreen extends StatefulWidget {
  final NotificationEntity? notificationEntity;
  final bool? navigateFromCell;

  const TemperatureNotificationReadingScreen(
      {super.key,
      required this.notificationEntity,
      required this.navigateFromCell});

  @override
  State<TemperatureNotificationReadingScreen> createState() =>
      _TemperatureNotificationReadingScreenState();
}

class _TemperatureNotificationReadingScreenState
    extends State<TemperatureNotificationReadingScreen> {
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
              AppColor.topGradient,
              AppColor.backgroundColor // Colors.white, // Xanh nhạt nhất
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
                height: SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenHeight * 0.025
                    : SizeConfig.screenHeight * 0.005,
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
                    ? SizeConfig.screenHeight * 0.025
                    : SizeConfig.screenHeight * 0.005,
              ),
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.notificationEntity?.bodyTemperatureEntity
                            ?.imageLink ??
                        ""
                    : null,
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.015,
              ),
              Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.035,
                    right: SizeConfig.screenWidth * 0.035,
                    top: SizeConfig.screenHeight * 0.015,
                  ),
                  margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.1),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenDiagonal < 1350
                      ? SizeConfig.screenHeight * 0.26
                      : SizeConfig.screenHeight * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(translation(context).bodyTemperature,
                          style: AppTextTheme.title2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.06,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: SizeConfig.screenHeight * 0.005),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "${widget.notificationEntity?.bodyTemperatureEntity!.temperature!}°",
                                  style: AppTextTheme.body0.copyWith(
                                    letterSpacing: -4,
                                    fontSize: SizeConfig.screenDiagonal * 0.08,
                                    color: widget.notificationEntity
                                        ?.bodyTemperatureEntity!.statusColor,
                                  )),
                              TextSpan(
                                  text: 'C',
                                  style: AppTextTheme.body0.copyWith(
                                    fontSize: SizeConfig.screenDiagonal * 0.065,
                                    color: widget.notificationEntity
                                        ?.bodyTemperatureEntity!.statusColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.01),
                      Center(
                        child: Center(
                          child: Text(
                              softWrap: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              "${widget.notificationEntity?.bodyTemperatureEntity!.statusComment(context)}",
                              style: AppTextTheme.body2.copyWith(
                                color: widget.notificationEntity
                                    ?.bodyTemperatureEntity!.statusColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.screenWidth * 0.055,
                              )),
                        ),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RectangleButton(
                    editSizeText: true,
                    sizeText: SizeConfig.screenDiagonal * 0.016,
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
                    sizeText: SizeConfig.screenDiagonal * 0.016,
                    height: SizeConfig.screenHeight * 0.07,
                    width: SizeConfig.screenWidth * 0.45,
                    title: translation(context).goToNotificationScreen,
                    buttonColor: Colors.red,
                    onTap: () {
                      // if (_isLoading == false) {
                      (widget.navigateFromCell == true)
                          ? Navigator.pop(context)
                          : Navigator.pushNamed(context, RouteList.notification,
                              arguments: userDataData.getUser()?.id);
                      // }
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
