import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/line_decor.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../classes/language_constant.dart';
import '../../common_widget/screen_form/custom_screen_form.dart';
import '../../theme/app_text_theme.dart';

//Class Home
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _PatientListState();
}

class _PatientListState extends State<NotificationScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return CustomScreenForm(
        isShowAppBar: true,
        isShowLeadingButton: true,
        isShowBottomNayvigationBar: true,
        isShowRightButon: false,
        backgroundColor: AppColor.white,
        appBarColor: AppColor.topGradient,

        // rightButton: IconButton(
        //   onPressed: gotoRegistPatientScreen,
        //   icon: const Icon(Icons.add),
        title: translation(context).notification,
        // ),
        selectedIndex: 1,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.screenWidth * 0.1),
            height: double.infinity,
            width: SizeConfig.screenWidth * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                lineDecor(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return NotificationCell(context,"");
                    },
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget NotificationCell(
  BuildContext context,
  String indicator,
) {
  SizeConfig.init(context);
  return Container(
    margin: EdgeInsets.only(
        bottom: SizeConfig.screenWidth * 0.02,
        top: SizeConfig.screenWidth * 0.025),
    height: SizeConfig.screenWidth * 0.45,
    width: SizeConfig.screenWidth * 0.85,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
            color: indicator == "Huyết áp"
                ? AppColor.bloodPressureEquip
                : indicator == "Thân nhiệt"
                    ? AppColor.bodyTemperatureColor
                    : AppColor.bloodGlucosColor,
            width: 3)),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: SizeConfig.screenWidth * 0.07,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: indicator == "Huyết áp"
                    ? AppColor.bloodPressureEquip
                    : indicator == "Thân nhiệt"
                        ? AppColor.bodyTemperatureColor
                        : AppColor.bloodGlucosColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.01,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Nguyễn văn A",
                                style: AppTextTheme.body3.copyWith(
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " - P001",
                                style: AppTextTheme.body3.copyWith(
                                    fontSize: SizeConfig.screenWidth * 0.04,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text("16:00 27/8/2023",
                      style: AppTextTheme.body4.copyWith(
                        fontSize: SizeConfig.screenWidth * 0.03,
                      )),
                ],
              )),

          indicator == "Huyết áp"
                    ?  SizedBox(
              width: SizeConfig.screenWidth * 0.7,
              height: SizeConfig.screenWidth * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("SYS",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500)),
                      Text("120",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff424242))),
                      Text("mmHg",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff888282)))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.025,
                            bottom: SizeConfig.screenWidth * 0.025),
                        width: SizeConfig.screenWidth * 0.2,
                        height: SizeConfig.screenWidth * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: const Color.fromARGB(255, 255, 210, 186),
                        ),
                        child: Center(
                          child: Text( indicator,
                              style: AppTextTheme.body3.copyWith(
                                  fontSize: SizeConfig.screenWidth * 0.03,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Text("DIA",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500)),
                      Text("78",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff424242))),
                      Text("mmHg",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff888282)))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("PUL",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500)),
                      Text("80",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff424242))),
                      Text("bpm",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff888282)))
                    ],
                  )
                ],
              )): indicator == "Thân nhiệt"?
               SizedBox(
              width: SizeConfig.screenWidth * 0.7,
              height: SizeConfig.screenWidth * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("SYS",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500)),
                      Text("120",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff424242))),
                      Text("mmHg",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff888282)))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.025,
                            bottom: SizeConfig.screenWidth * 0.025),
                        width: SizeConfig.screenWidth * 0.2,
                        height: SizeConfig.screenWidth * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: const Color.fromARGB(255, 255, 210, 186),
                        ),
                        child: Center(
                          child: Text( indicator,
                              style: AppTextTheme.body3.copyWith(
                                  fontSize: SizeConfig.screenWidth * 0.03,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Text("DIA",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500)),
                      Text("78",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff424242))),
                      Text("mmHg",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff888282)))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("PUL",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              fontWeight: FontWeight.w500)),
                      Text("80",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.085,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff424242))),
                      Text("bpm",
                          style: AppTextTheme.body3.copyWith(
                              fontSize: SizeConfig.screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff888282)))
                    ],
                  )
                ],
              )):Container()
                
                        ,
        ]),
  );
}
