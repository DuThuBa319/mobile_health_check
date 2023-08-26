import 'package:mobile_health_check/common/service/onesginal/onesignal_service.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/image_picker_widget/custom_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget_setting.dart';

import '../../../classes/language_constant.dart';
import '../../../function.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/line_decor.dart';
import '../../route/route_list.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/theme_color.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu({super.key});

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CustomScreenForm(
        title: translation(context).setting,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: true,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, RouteList.patientList),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
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
                      child: Text("Dr.Tên Bác Sĩ",
                          style: AppTextTheme.body0
                              .copyWith(fontWeight: FontWeight.bold))),
                  Center(
                      child: Text("+84 0395651845", style: AppTextTheme.body3)),
                  SizedBox(height: SizeConfig.screenWidth * 0.1),
                  lineDecor(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteList.settingDrPassword),
                    child: settingMenuCell(
                        translation(context).updatePassword,
                      context),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteList.settingDrPhone),
                    child: settingMenuCell(
                        translation(context).updatePhoneNumber,
                      
                        context),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteList.settingLanguage),
                    child: settingMenuCell(
                        translation(context).language,
                       context),
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.01),
                  Center(
                    child: CommonButton(
                        height: SizeConfig.screenHeight * 0.07,
                        title: translation(context).logOut,
                        buttonColor: AppColor.saveSetting,
                        onTap: () async {
                          final response = await OneSignalNotificationService
                              .sendNotification("hello", "Notification");
                          print(response.body.toString());
                        }),
                  )
                ]),
          ),
        ));
  }
}
