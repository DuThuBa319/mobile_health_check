import 'package:mobile_health_check/domain/entities/notificaion_onesignal_entity.dart';
import 'package:mobile_health_check/function.dart';
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
  // final bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(milliseconds: 3000), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, SizeConfig.screenWidth * 0.08, 12, 10),
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
                            fontSize: SizeConfig.screenWidth * 0.05,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        " ${DateFormat('HH:mm').format(widget.notificationEntity?.sendDate ?? DateTime(2023, 9, 16, 12, 00))}  ${DateFormat('dd/MM/yyyy').format(widget.notificationEntity?.sendDate ?? DateTime(2023, 9, 16, 12, 00))}",
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.04),
                      ),
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenWidth * 0.02,
              ),
              CustomImagePicker(
                imagePath: widget
                        .notificationEntity?.bodyTemperatureEntity!.imageLink ??
                    widget
                        .notificationEntity?.bodyTemperatureEntity!.imageLink!,
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenWidth * 0.02,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.1),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.26,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(translation(context).bodyTemperature,
                          style: AppTextTheme.title2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.075,
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
                                      "${widget.notificationEntity?.bodyTemperatureEntity!.temperature ?? widget.notificationEntity?.bodyTemperatureEntity!.temperature!}°",
                                  style: AppTextTheme.body0.copyWith(
                                    letterSpacing: -4,
                                    fontSize: SizeConfig.screenWidth * 0.2,
                                    color: widget.notificationEntity
                                        ?.bodyTemperatureEntity!.statusColor,
                                  )),
                              TextSpan(
                                  text: 'C',
                                  style: AppTextTheme.body0.copyWith(
                                    fontSize: SizeConfig.screenWidth * 0.15,
                                    color: widget.notificationEntity
                                        ?.bodyTemperatureEntity!.statusColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenWidth * 0.05),
                      Center(
                        child: Text(
                            "${widget.notificationEntity?.bodyTemperatureEntity!.statusComment(context)}",
                            style: AppTextTheme.body2.copyWith(
                                color: widget.notificationEntity
                                    ?.bodyTemperatureEntity!.statusColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.screenWidth * 0.06)),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RectangleButton(
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
                  RectangleButton(
                    editSizeText: true,
                    sizeText: SizeConfig.screenWidth * 0.04,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
