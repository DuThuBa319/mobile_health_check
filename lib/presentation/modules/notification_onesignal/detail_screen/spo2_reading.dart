import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/common_widget/rectangle_button.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';
import '../../../../domain/entities/notificaion_onesignal_entity.dart';
import '../../../common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';

class Spo2NotificationReadingScreen extends StatefulWidget {
  final NotificationEntity? notificationEntity;
  final bool? navigateFromCell;

  const Spo2NotificationReadingScreen(
      {super.key,
      required this.notificationEntity,
      required this.navigateFromCell});

  @override
  State<Spo2NotificationReadingScreen> createState() =>
      _Spo2NotificationReadingScreenState();
}

class _Spo2NotificationReadingScreenState
    extends State<Spo2NotificationReadingScreen> {
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, SizeConfig.screenWidth * 0.06, 12, 10),
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
                height: SizeConfig.screenWidth * 0.08,
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
                height: SizeConfig.screenWidth * 0.08,
              ),
              CustomImagePicker(
                imagePath: widget.notificationEntity?.spo2Entity?.imageLink ??
                    widget.notificationEntity?.spo2Entity?.imageLink,
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenWidth * 0.08,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin:
                      EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.02),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.23,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(translation(context).oximeter,
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
                                      "${widget.notificationEntity?.spo2Entity?.spo2 ?? widget.notificationEntity!.spo2Entity!.spo2!}",
                                  style: AppTextTheme.body0.copyWith(
                                      letterSpacing: -4,
                                      fontSize: SizeConfig.screenWidth * 0.25,
                                      // color: widget.notificationEntity!.spo2Entity!.statusColor,
                                      color: widget.notificationEntity
                                          ?.spo2Entity?.statusColor)),
                              TextSpan(
                                  text: ' %',
                                  style: AppTextTheme.body0.copyWith(
                                      fontSize: SizeConfig.screenWidth * 0.08,
                                      // color: widget.notificationEntity!.spo2Entity!.statusColor,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenWidth * 0.05),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenWidth * 0.05),
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
