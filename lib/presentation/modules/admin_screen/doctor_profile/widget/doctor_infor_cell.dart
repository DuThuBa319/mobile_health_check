import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobile_health_check/function.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import '../../../../../classes/language.dart';
import '../../../../../domain/entities/doctor_infor_entity.dart';
import '../../../../common_widget/common_button.dart';
import '../../../../theme/theme_color.dart';

class DoctorInforCell extends StatefulWidget {
  final DoctorInforEntity doctorInforEntity;
  const DoctorInforCell({
    Key? key,
    required this.doctorInforEntity,
  }) : super(key: key);

  @override
  State<DoctorInforCell> createState() => _DoctorInforCellState();
}

class _DoctorInforCellState extends State<DoctorInforCell> {
  bool isWifiAvailable = false;
  bool is4GAvailable = false;

  void checkWifiAvailability() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      // ignore: unrelated_type_equality_checks
      isWifiAvailable = connectivityResult == ConnectivityResult.wifi;
      is4GAvailable = connectivityResult == ConnectivityResult.mobile;
    });
  }

  @override
  void initState() {
    checkWifiAvailability();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        title: translation(context).doctorIn4,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        // selectedIndex: 2,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: SizeConfig.screenWidth * 0.05,
              left: SizeConfig.screenWidth * 0.05,
              right: SizeConfig.screenWidth * 0.05,
            ),
            height: SizeConfig.screenHeight * 0.8,
            width: SizeConfig.screenWidth * 0.9,
            child: ListView(children: [
              in4Cell("${translation(context).name}: ",
                  widget.doctorInforEntity.name),
              in4Cell("${translation(context).phoneNumber}: ",
                  widget.doctorInforEntity.phoneNumber),
              in4Cell(
                  "${translation(context).age}: ",
                  (widget.doctorInforEntity.age == 0)
                      ? translation(context).notUpdate
                      : "${widget.doctorInforEntity.age}"),
              in4Cell(
                "${translation(context).gender}: ",
                widget.doctorInforEntity.gender == 0
                    ? translation(context).male
                    : translation(context).female,
              ),
              in4Cell("${translation(context).address}: ",
                  "${widget.doctorInforEntity.address}"),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              CommonButton(
                  width: SizeConfig.screenWidth * 0.9,
                  height: SizeConfig.screenHeight * 0.07,
                  title: translation(context).back,
                  buttonColor: AppColor.saveSetting,
                  onTap: () {
                    Navigator.pop(context);
                  })
            ]),
          ),
        ));
  }
}

Widget in4Cell(String titile, String text) {
  return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.03,
          top: SizeConfig.screenHeight * 0.02),
      height: SizeConfig.screenHeight * 0.13,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
                text: titile,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.w500)),
            TextSpan(
              text: text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.screenWidth * 0.045),
            )
          ],
        ),
      ));
}
