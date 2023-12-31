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
                            widget.bloodPressureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      ),
                      Text(
                        DateFormat('HH:mm').format(
                            widget.bloodPressureEntity?.updatedDate ??
                                DateTime(2023, 9, 16, 12, 00)),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.06),
                      )
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenWidth * 0.08,
              ),
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.bloodPressureEntity?.imageLink ?? ''
                    : null, // Set imagePath to null if Wi-Fi is not available
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenWidth * 0.08,
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
                              Text(widget.bloodPressureEntity!.sys.toString(),
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget
                                          .bloodPressureEntity!.statusColor,
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
                              Text(widget.bloodPressureEntity!.pulse.toString(),
                                  style: AppTextTheme.title1.copyWith(
                                      color: widget
                                          .bloodPressureEntity!.statusColor,
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
                              color: widget.bloodPressureEntity!.statusColor),
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      widget.bloodPressureEntity!.statusColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 8,
                              width: SizeConfig.screenWidth * 0.72),
                          Icon(Icons.favorite,
                              color: widget.bloodPressureEntity!.statusColor),
                        ],
                      ),
                      Text(
                          // ignore: unrelated_type_equality_checks
                          widget.bloodPressureEntity!.statusComment(context),
                          style: AppTextTheme.body2.copyWith(
                              color: widget.bloodPressureEntity!.statusColor,
                              fontWeight: FontWeight.w700)),
                    ],
                  )),
              SizedBox(height: SizeConfig.screenWidth * 0.05),
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
