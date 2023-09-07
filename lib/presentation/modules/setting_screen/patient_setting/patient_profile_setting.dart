import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:flutter/material.dart';

import '../../../../classes/language_constant.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/screen_form/custom_screen_form_for_patient.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';

class SettingPatientProfile extends StatefulWidget {
  const SettingPatientProfile({super.key});

  @override
  State<SettingPatientProfile> createState() => _SettingPatientProfileState();
}

class _SettingPatientProfileState extends State<SettingPatientProfile> {
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
              top: SizeConfig.screenWidth * 0.05,
              left: SizeConfig.screenWidth * 0.05,
              right: SizeConfig.screenWidth * 0.05,
            ),
            height: SizeConfig.screenHeight * 0.8,
            width: SizeConfig.screenWidth * 0.9,
            child: ListView(children: [
              // settingProfileCell(
              //    userDataData.name, context, translation(context).name),
              // settingProfileCell( userDataData.phoneNumber, context,
              //     translation(context).phoneNumber),
              // settingProfileCell(
              //     "${ userDataData.age}", context, translation(context).age),
              // settingProfileCell("${ userDataData.height?.toInt()}", context,
              //     translation(context).height),
              // settingProfileCell("${ userDataData.weight?.toInt()}", context,
              //     translation(context).weight),
              // settingProfileCell( userDataData.street, context,
              //     translation(context).street),
              // settingProfileCell(
              //      userDataData.ward, context, translation(context).ward),
              // settingProfileCell(
              //      userDataData.city, context, translation(context).city),
              // settingProfileCell( userDataData.country, context,
              //     translation(context).country),

              // settingProfileCell(
              //    userDataData.street,
              //   context,
              // ),
              // settingProfileCell(
              //    userDataData.city,
              //   context,
              // ),
              // settingProfileCell(
              //    userDataData.country,
              //   context,
              // ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              Center(
                child: CommonButton(
                    width: SizeConfig.screenWidth * 0.9,
                    height: SizeConfig.screenHeight * 0.07,
                    title: translation(context).save,
                    buttonColor: AppColor.saveSetting,
                    onTap: () {
                      showToast(
                          translation(context).updatePhoneNumberSuccessfullly);
                    }),
              )
            ]),
          ),
        ));
  }
}
