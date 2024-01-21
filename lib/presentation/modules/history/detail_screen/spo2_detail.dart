import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:mobile_health_check/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../classes/language.dart';
import '../../../../domain/entities/spo2_entity.dart';
import '../../../common_widget/common.dart';
import '../../../theme/theme_color.dart';

class Spo2DetailScreen extends StatefulWidget {
  final Spo2Entity? spo2Entity;
  const Spo2DetailScreen({super.key, required this.spo2Entity});

  @override
  State<Spo2DetailScreen> createState() => _Spo2DetailScreenState();
}

class _Spo2DetailScreenState extends State<Spo2DetailScreen> {
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
        padding:
            EdgeInsets.fromLTRB(12, SizeConfig.screenHeight * 0.04, 12, 10),
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
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        translation(context).time,
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.055),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy')
                            .format(widget.spo2Entity!.updatedDate!),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.055),
                      ),
                      Text(
                        DateFormat('HH:mm')
                            .format(widget.spo2Entity!.updatedDate!),
                        style: AppTextTheme.body1
                            .copyWith(fontSize: SizeConfig.screenWidth * 0.055),
                      )
                    ],
                  )),
              SizedBox(
                height: SizeConfig.screenHeight * 0.045,
              ),
              CustomImagePicker(
                imagePath: (isWifiAvailable || is4GAvailable)
                    ? widget.spo2Entity?.imageLink ?? ''
                    : null, // Set imagePath to null if Wi-Fi is not available
                isOnTapActive: true,
                isforAvatar: false,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.045,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: 10, right: 10, top: SizeConfig.screenHeight * 0.02),
                  margin:
                      EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.02),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(translation(context).oximeter,
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
                                  text: "${widget.spo2Entity!.spo2!}",
                                  style: AppTextTheme.body0.copyWith(
                                      letterSpacing: -4,
                                      fontSize:
                                          SizeConfig.screenDiagonal * 0.08,
                                      // color: widget.spo2Entity!.statusColor,
                                      color: widget.spo2Entity?.statusColor)),
                              TextSpan(
                                  text: ' %',
                                  style: AppTextTheme.body0.copyWith(
                                      fontSize:
                                          SizeConfig.screenDiagonal * 0.05,
                                      // color: widget.spo2Entity!.statusColor,
                                      color: widget.spo2Entity?.statusColor)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.005),
                      Center(
                        child: Text(widget.spo2Entity!.statusComment(context),
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppTextTheme.body2.copyWith(
                              color: widget.spo2Entity!.statusColor,
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
