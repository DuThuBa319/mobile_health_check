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
                  height: SizeConfig.screenHeight * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        translation(context).time,
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(
                            widget.temperatureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      ),
                      Text(
                        DateFormat('HH:mm').format(
                            widget.temperatureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      )
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenWidth * 0.02,
              ),
              // _isLoading
              //     ? Container(
              //         margin: const EdgeInsets.only(left: 15),
              //         height: SizeConfig.screenWidth * 0.9,
              //         width: SizeConfig.screenWidth * 0.9,
              //         child: const Center(child: CircularProgressIndicator()),
              //       )
              //     :
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.temperatureEntity?.imageLink ?? ''
                    : null, // Set imagePath to null if Wi-Fi is not available
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
                                      "${widget.temperatureEntity!.temperature ?? widget.temperatureEntity!.temperature!}°",
                                  style: AppTextTheme.body0.copyWith(
                                    letterSpacing: -4,
                                    fontSize: SizeConfig.screenWidth * 0.2,
                                    color:
                                        widget.temperatureEntity!.statusColor,
                                  )),
                              TextSpan(
                                  text: 'C',
                                  style: AppTextTheme.body0.copyWith(
                                    fontSize: SizeConfig.screenWidth * 0.15,
                                    color:
                                        widget.temperatureEntity!.statusColor,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      // Row(

                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //         "${widget.TemperatureEntity!.Temperature ?? widget.TemperatureEntity!.Temperature!}",
                      //         style: AppTextTheme.body0.copyWith(
                      //           letterSpacing: -4,
                      //           fontSize: SizeConfig.screenWidth * 0.2,
                      //           color: widget.TemperatureEntity!.statusColor,
                      //         )),
                      //     const SizedBox(
                      //       width: 2,
                      //     ),
                      //     Text('mg/dL',
                      //         style: AppTextTheme.body0.copyWith(
                      //           fontSize: SizeConfig.screenWidth * 0.08,
                      //           color: widget.TemperatureEntity!.statusColor,
                      //         )),
                      //   ],
                      // ),
                      SizedBox(height: SizeConfig.screenWidth * 0.05),
                      Center(
                        child: Text(
                            widget.temperatureEntity!.statusComment(context),
                            style: AppTextTheme.body2.copyWith(
                                color: widget.temperatureEntity!.statusColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.screenWidth * 0.06)),
                      ),
                    ],
                  )),
              RectangleButton(
                height: SizeConfig.screenHeight * 0.07,
                title: translation(context).back,
                buttonColor: Colors.red,
                onTap: () {
                  // if (_isLoading == false) {
                  Navigator.pop(context);
                  // }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
