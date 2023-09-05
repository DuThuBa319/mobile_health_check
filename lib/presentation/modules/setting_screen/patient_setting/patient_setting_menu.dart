import 'package:mobile_health_check/common/service/onesginal/onesignal_service.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget_setting.dart';

import '../../../../classes/language_constant.dart';
import '../../../../function.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/line_decor.dart';
import '../../../common_widget/screen_form/custom_screen_form_for_patient.dart';
import '../../../route/route_list.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';



class PatientSettingMenu extends StatefulWidget {
  const PatientSettingMenu({super.key});

  @override
  State<PatientSettingMenu> createState() => _PatientSettingMenuState();
}

class _PatientSettingMenuState extends State<PatientSettingMenu> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return PatientCustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, RouteList.selectEquip),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 1,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: SizeConfig.screenWidth * 0.02,
              left: SizeConfig.screenWidth * 0.05,
              right: SizeConfig.screenWidth * 0.05,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenWidth * 0.02),
                  const Center(
                    child: CustomImagePicker(
                      imagePath: null,
                      isOnTapActive: true,
                      isforAvatar: true,
                    ),
                  ),
                  Center(
                      child: Text(userDataData.getUser()?.name ?? '--',
                          style: AppTextTheme.body0.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.screenWidth * 0.07))),
                  Center(
                      child: Text(
                    userDataData.getUser()?.phoneNumber ?? '--',
                    style: AppTextTheme.body2,
                  )),
                  SizedBox(height: SizeConfig.screenWidth * 0.1),
                  lineDecor(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteList.patientSettingPass),
                    child: settingMenuCell(
                        translation(context).updatePassword, context),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteList.patientSettingPhone),
                    child: settingMenuCell(
                        translation(context).updatePhoneNumber, context),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteList.patientSettingLanguage),
                    child:
                        settingMenuCell(translation(context).language, context),
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.01),
                  Center(
                    child: CommonButton(
                        height: SizeConfig.screenHeight * 0.07,
                        title: translation(context).logOut,
                        buttonColor: AppColor.saveSetting,
                        onTap: () {
                          OneSignalNotificationService
                              .unsubscribeFromNotifications(
                                  doctorId: userDataData.getUser()!.id!);
                          notificationData.clearData();

                          userDataData.clearData();
                          firebaseAuthService.signOut();

                          Navigator.pushNamed(context, RouteList.login);
                        }),
                  )
                ]),
          ),
        ));
  }
}
