import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/temperature_entity.dart';
import '../../../common_widget/common.dart';
import '../../../theme/theme_color.dart';

class TemperatureDetailScreen extends StatefulWidget {
  final TemperatureEntity? temperatureEntity;
  const TemperatureDetailScreen({super.key, required this.temperatureEntity});

  @override
  State<TemperatureDetailScreen> createState() =>
      _TemperatureDetailScreenState();
}

class _TemperatureDetailScreenState extends State<TemperatureDetailScreen> {
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
                height: SizeConfig.screenHeight * 0.03,
              ),
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.screenWidth * 0.01)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        translation(context).time,
                        style: AppTextTheme.body1.copyWith(
                          fontSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.055
                              : SizeConfig.screenWidth * 0.048,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(
                            widget.temperatureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1.copyWith(
                          fontSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.055
                              : SizeConfig.screenWidth * 0.048,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(
                            widget.temperatureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1.copyWith(
                          fontSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.055
                              : SizeConfig.screenWidth * 0.048,
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenHeight * 0.025
                    : SizeConfig.screenHeight * 0.015,
              ),
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.temperatureEntity?.imageLink ?? ''
                    : null, // Set imagePath to null if Wi-Fi is not available
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenDiagonal < 1350
                    ? SizeConfig.screenHeight * 0.025
                    : SizeConfig.screenHeight * 0.015,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.035,
                      right: SizeConfig.screenWidth * 0.035,
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
                                      "${widget.temperatureEntity!.temperature!}°",
                                  style: AppTextTheme.body0.copyWith(
                                    letterSpacing: -4,
                                    fontSize: SizeConfig.screenDiagonal * 0.08,
                                    color:
                                        widget.temperatureEntity!.statusColor,
                                  )),
                              TextSpan(
                                  text: 'C',
                                  style: AppTextTheme.body0.copyWith(
                                    fontSize: SizeConfig.screenDiagonal * 0.065,
                                    color:
                                        widget.temperatureEntity!.statusColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.01),
                      Center(
                        child: Text(
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            widget.temperatureEntity!.statusComment(context),
                            style: AppTextTheme.body2.copyWith(
                              color: widget.temperatureEntity!.statusColor,
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.screenWidth * 0.055,
                            )),
                      ),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              RectangleButton(
                height: SizeConfig.screenHeight * 0.07,
                title: translation(context).back,
                buttonColor: Colors.red,
                onTap: () {
                  // if (_isLoading == false) {
                  Navigator.pop(context);
                  // }
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
