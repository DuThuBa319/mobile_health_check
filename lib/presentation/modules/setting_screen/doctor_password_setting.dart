import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget_setting.dart';

import '../../../classes/language_constant.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/line_decor.dart';
import '../../route/route_list.dart';
import '../../theme/theme_color.dart';

class SettingDrPassword extends StatefulWidget {
  const SettingDrPassword({super.key});

  @override
  State<SettingDrPassword> createState() => _SettingDrPasswordState();
}

class _SettingDrPasswordState extends State<SettingDrPassword> {
  bool showPass = true;
  final passController = TextEditingController();
  String pass = "";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return CustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.topGradient,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.setting),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  lineDecor(),
                  Stack(
                    children: [
                      SettingPasswordCell(
                          selectSetting: translation(context).oldPassword,
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.9,
                          showPass: showPass),
                    ],
                  ),
                  SettingPasswordCell(
                      selectSetting: translation(context).newPassword,
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.9,
                      showPass: showPass),
                  SettingPasswordCell(
                      selectSetting: translation(context).confirmPass,
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.9,
                      showPass: showPass),
                  SizedBox(height: screenHeight * 0.01),
                  Center(
                    child: CommonButton(
                        height: screenHeight * 0.07,
                        title: translation(context).save,
                        buttonColor: AppColor.saveSetting,
                        onTap: () {
                          showToast("Update Password Successfullly");
                        }),
                  )
                ]),
          ),
        ));
  }
}
