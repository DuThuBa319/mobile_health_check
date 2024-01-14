import 'package:mobile_health_check/common/service/onesginal/onesignal_service.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget/widget_setting.dart';
import '../../../classes/language.dart';
import '../../../utils/size_config.dart';
import '../../common_widget/common.dart';

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
        selectedIndex: 1,
        isScrollable: true,
        child: Container(
          padding: EdgeInsets.only(
            top: SizeConfig.screenWidth * 0.1,
          ),
          margin: EdgeInsets.only(
            top: SizeConfig.screenWidth * 0.02,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (userDataData.getUser()?.role == UserRole.relative ||
                        userDataData.getUser()?.role == UserRole.patient)
                    ? Center(
                        child: CustomImagePicker(
                          gender: userDataData.getUser()?.gender,
                          age: userDataData.getUser()?.age,
                          imagePath: null,
                          isOnTapActive: true,
                          isforAvatar: true,
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                            color: AppColor.backgroundColor,
                            shape: BoxShape.circle),
                        height: SizeConfig.screenDiagonal * 0.11,
                        width: SizeConfig.screenDiagonal * 0.11,
                        child: ClipRect(
                            child: Image.asset(
                          (userDataData.getUser()?.role == UserRole.doctor)
                              ? Assets.doctor
                              : Assets.family,
                          fit: BoxFit.fill,
                        )),
                      ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.8,
                  child: Text(
                      textAlign: TextAlign.center,
                      (userDataData.getUser()?.role == UserRole.doctor)
                          ? "Dr.${userDataData.getUser()?.name}"
                          : "${userDataData.getUser()?.name}",
                      style: AppTextTheme.body0.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenDiagonal * 0.025)),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                //! ĐỔI MẬT KHẨU
                GestureDetector(
                  child: settingMenuCell(
                      translation(context).updatePassword, context),
                  onTap: () {
                    Navigator.pushNamed(context, RouteList.settingPass);
                  },
                ),

                //! CẬP NHẬT THÔNG TIN
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteList.settingProfile),
                  child: settingMenuCell(
                      translation(context).updateProfile, context),
                ),

                //! ĐỔI NGÔN NGỮ
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteList.settingLanguage),
                  child:
                      settingMenuCell(translation(context).language, context),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.005),
                RectangleButton(
                    height: SizeConfig.screenHeight * 0.07,
                    title: translation(context).logOut,
                    buttonColor: AppColor.saveSetting,
                    onTap: () {
                      showWarningDialog(
                        context: context,
                        message: translation(context).areYouSureToLogOut,
                        title: translation(context).logOut,
                        onClose1: () {},
                        onClose2: () async {
                          if ((userDataData.getUser()?.role ==
                                  UserRole.doctor ||
                              userDataData.getUser()?.role ==
                                  UserRole.relative)) {
                            OneSignalNotificationService
                                .unsubscribeFromNotifications(
                                    userId: userDataData.getUser()!.id!);
                            await notificationData.clearData();
                          }

                          if (userDataData.getUser()?.role ==
                              UserRole.patient) {
                            await notificationData.clearData();
                          }
                          await userDataData.clearData();
                          await userDataData.setLogout();
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteList.login, (Route<dynamic> route) => false);
                        },
                      );
                    })
              ]),
        ));
  }
}
