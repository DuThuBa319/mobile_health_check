import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/blood_sugar_entity.dart';
import '../../../common_widget/common.dart';
import '../../../theme/theme_color.dart';

class BloodSugarDetailScreen extends StatefulWidget {
  final BloodSugarEntity? bloodSugarEntity;
  const BloodSugarDetailScreen({super.key, required this.bloodSugarEntity});

  @override
  State<BloodSugarDetailScreen> createState() => _BloodSugarDetailScreenState();
}

class _BloodSugarDetailScreenState extends State<BloodSugarDetailScreen> {
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
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 0.0065)),
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
                        DateFormat('dd/MM/yyyy')
                            .format(widget.bloodSugarEntity!.updatedDate!),
                        style: AppTextTheme.body1.copyWith(
                          fontSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.055
                              : SizeConfig.screenWidth * 0.048,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm')
                            .format(widget.bloodSugarEntity!.updatedDate!),
                        style: AppTextTheme.body1.copyWith(
                          fontSize: SizeConfig.screenDiagonal < 1350
                              ? SizeConfig.screenWidth * 0.055
                              : SizeConfig.screenWidth * 0.048,
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenHeight * 0.045,
              ),
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.bloodSugarEntity?.imageLink ?? ''
                    : null, // Set imagePath to null if Wi-Fi is not available
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.045,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.01,
                      right: SizeConfig.screenWidth * 0.01,
                      top: SizeConfig.screenHeight * 0.008),
                  margin:
                      EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.02),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.26,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenWidth * 0.0065)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(translation(context).bloodSugar,
                          style: AppTextTheme.title2.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.065,
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
                                      "${widget.bloodSugarEntity!.bloodSugar!}",
                                  style: AppTextTheme.body0.copyWith(
                                    letterSpacing: -4,
                                    fontSize: SizeConfig.screenDiagonal * 0.08,
                                    color: widget.bloodSugarEntity!.statusColor,
                                  )),
                              TextSpan(
                                  text: ' mg/dL',
                                  style: AppTextTheme.body0.copyWith(
                                    fontSize: SizeConfig.screenDiagonal * 0.045,
                                    color: widget.bloodSugarEntity!.statusColor,
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
                            widget.bloodSugarEntity!.statusComment(context),
                            style: AppTextTheme.body2.copyWith(
                              color: widget.bloodSugarEntity!.statusColor,
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
              SizedBox(height: SizeConfig.screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
