import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:mobile_health_check/domain/entities/patient_infor_entity.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/empty_space.dart';
import 'package:mobile_health_check/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';

import '../../../../../classes/language.dart';
import '../../../../common_widget/rectangle_button.dart';
import '../../../../theme/theme_color.dart';

class PatientInforCell extends StatefulWidget {
  final PatientInforEntity patientInforEntity;
  const PatientInforCell({
    Key? key,
    required this.patientInforEntity,
  }) : super(key: key);

  @override
  State<PatientInforCell> createState() => _PatientInforCellState();
}

class _PatientInforCellState extends State<PatientInforCell> {
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
        title: translation(context).patientIn4,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        isScrollable: true,
        // selectedIndex: 2,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(
              top: SizeConfig.screenWidth * 0.05,
            ),
            height: SizeConfig.screenHeight * 0.8,
            width: SizeConfig.screenWidth * 0.95,
            child: ListView(children: [
              patientIn4Cell(context, "${translation(context).name}: ",
                  widget.patientInforEntity.name),
              patientIn4Cell(context, "${translation(context).phoneNumber}: ",
                  widget.patientInforEntity.phoneNumber,
                  isSelectable: true),
              patientIn4Cell(
                  context,
                  "${translation(context).age}: ",
                  (widget.patientInforEntity.age == 0)
                      ? translation(context).notUpdate
                      : "${widget.patientInforEntity.age}"),
              patientIn4Cell(
                context,
                "${translation(context).gender}: ",
                widget.patientInforEntity.gender == 0
                    ? translation(context).male
                    : translation(context).female,
              ),
              patientIn4Cell(
                  context,
                  "${translation(context).height}: ",
                  (widget.patientInforEntity.height?.toInt() == 0)
                      ? "${translation(context).notUpdate} (cm)"
                      : "${widget.patientInforEntity.height?.toInt()} (cm)"),
              patientIn4Cell(
                  context,
                  "${translation(context).weight}: ",
                  (widget.patientInforEntity.weight?.toInt() == 0)
                      ? "${translation(context).notUpdate} (kg)"
                      : "${widget.patientInforEntity.weight?.toInt()} (kg)"),
              patientIn4Cell(
                  context,
                  "${translation(context).address}: ",
                  (widget.patientInforEntity.address == "" ||
                          widget.patientInforEntity.address == null)
                      ? translation(context).notUpdate
                      : widget.patientInforEntity.address!,
                  isSelectable: true),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              RectangleButton(
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

Widget patientIn4Cell(BuildContext context, String title, String text,
    {bool isSelectable = false}) {
  return Container(
      margin: EdgeInsets.only(
        bottom: SizeConfig.screenWidth * 0.03,
      ),
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.025,
          top: SizeConfig.screenHeight * 0.015),
      height: title == "${translation(context).address}: "
          ? SizeConfig.screenHeight * 0.16
          : SizeConfig.screenHeight * 0.1,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
      ),
      child: RichText(
        maxLines: title == "${translation(context).address}: " ? 3 : 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
                text: title,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: SizeConfig.screenWidth * 0.055,
                    fontWeight: FontWeight.w500)),
            TextSpan(
              text: text,
              style: TextStyle(
                  color: Colors.black, fontSize: SizeConfig.screenWidth * 0.05),
            ),
            const WidgetSpan(child: SizedBox(width: 10)),
            WidgetSpan(
              child: isSelectable
                  ? InkWell(
                      child: const Icon(Icons.copy, color: Colors.black54),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: text));
                        showToast(translation(context).copySuccessfully);
                      },
                    )
                  : emptySpace(5),
            )
          ],
        ),
      ));
}
