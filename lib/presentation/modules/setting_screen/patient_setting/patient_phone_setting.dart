import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget_setting.dart';

import '../../../../classes/language_constant.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/line_decor.dart';
import '../../../common_widget/screen_form/custom_screen_form_for_patient.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';


class SettingPatientPhoneNumber extends StatefulWidget {
  const SettingPatientPhoneNumber({super.key});

  @override
  State<SettingPatientPhoneNumber> createState() =>
      _SettingPatientPhoneNumberState();
}

class _SettingPatientPhoneNumberState extends State<SettingPatientPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return PatientCustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, RouteList.patientSetting),
            icon: const Icon(Icons.arrow_back)),
        // selectedIndex: 2,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: SizeConfig.screenWidth * 0.2,
              left: SizeConfig.screenWidth * 0.05,
              right: SizeConfig.screenWidth * 0.05,
            ),
            height: SizeConfig.screenHeight * 0.8,
            width: SizeConfig.screenWidth * 0.9,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  lineDecor(),
                  settingPhoneCell(
                      translation(context).oldPhoneNumber, context),
                  settingPhoneCell(
                    translation(context).newPhoneNumber,
                    context,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Center(
                    child: CommonButton(
                        width: SizeConfig.screenWidth * 0.9,
                        height: SizeConfig.screenHeight * 0.07,
                        title: translation(context).save,
                        buttonColor: AppColor.saveSetting,
                        onTap: () {
                          showToast(translation(context)
                              .updatePhoneNumberSuccessfullly);
                        }),
                  )
                ]),
          ),
        ));
  }
}
