import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/blood_pressure_entity.dart';
import '../../../../utils/size_config.dart';
import '../../../common_widget/common.dart';

class BloodPressureDetailScreen extends StatefulWidget {
  final BloodPressureEntity? bloodPressureEntity;
  const BloodPressureDetailScreen(
      {super.key, required this.bloodPressureEntity});

  @override
  State<BloodPressureDetailScreen> createState() =>
      _BloodPressureDetailScreenState();
}

class _BloodPressureDetailScreenState extends State<BloodPressureDetailScreen> {
  // bool _isLoading = true;
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
            SizeConfig.screenHeight * 0.005, SizeConfig.screenWidth * 0.02, 0),
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
                height: SizeConfig.screenHeight * 0.03,
              ),
              Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 0.005)),
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
                            widget.bloodPressureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1.copyWith(
                          fontSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.055
                              : SizeConfig.screenWidth * 0.048,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(
                            widget.bloodPressureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1.copyWith(
                            fontSize: SizeConfig.screenDiagonal < 1350
                                ? SizeConfig.screenWidth * 0.055
                                : SizeConfig.screenWidth * 0.048),
                      )
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenHeight * 0.045,
              ),
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.bloodPressureEntity?.imageLink ?? ''
                    : null, // Set imagePath to null if Wi-Fi is not available
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.045,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.006,
                      right: SizeConfig.screenWidth * 0.006,
                      top: SizeConfig.screenHeight * 0.01),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.26,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 0.005)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('SYS',
                                  style: AppTextTheme.title2.copyWith(
                                      fontSize: SizeConfig.screenHeight * 0.028,
                                      color: Colors.black)),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.005,
                              ),
                              Text(
                                'mmHg',
                                style: AppTextTheme.title5.copyWith(
                                  fontSize: SizeConfig.screenHeight * 0.022,
                                ),
                              ),
                              SizedBox(
                                  height: SizeConfig.screenDiagonal * 0.022),
                              Text(widget.bloodPressureEntity!.sys.toString(),
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget
                                          .bloodPressureEntity!.statusColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize:
                                          SizeConfig.screenDiagonal * 0.04)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('PUL',
                                  style: AppTextTheme.title2.copyWith(
                                      fontSize: SizeConfig.screenHeight * 0.028,
                                      color: Colors.black)),
                              const SizedBox(height: 5),
                              Text(
                                'bpm',
                                style: AppTextTheme.title5.copyWith(
                                  fontSize: SizeConfig.screenHeight * 0.022,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenWidth * 0.04),
                              Text(widget.bloodPressureEntity!.pulse.toString(),
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget
                                          .bloodPressureEntity!.statusColor,
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
                              color: widget.bloodPressureEntity!.statusColor,
                              size: SizeConfig.screenWidth * 0.035),
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      widget.bloodPressureEntity!.statusColor,
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.screenWidth * 0.0065)),
                              height: SizeConfig.screenHeight * 0.0065,
                              width: SizeConfig.screenWidth * 0.72),
                          Icon(
                            Icons.favorite,
                            size: SizeConfig.screenWidth * 0.035,
                            color: widget.bloodPressureEntity!.statusColor,
                          ),
                        ],
                      ),
                      Text(
                          softWrap: true,
                          maxLines: 2,
                          // ignore: unrelated_type_equality_checks
                          widget.bloodPressureEntity!.statusComment(context),
                          textAlign: TextAlign.center,
                          style: AppTextTheme.body2.copyWith(
                              color: widget.bloodPressureEntity!.statusColor,
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.screenWidth * 0.055)),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenHeight * 0.015),
              RectangleButton(
                height: SizeConfig.screenHeight * 0.07,
                title: translation(context).back,
                buttonColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  // }
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
