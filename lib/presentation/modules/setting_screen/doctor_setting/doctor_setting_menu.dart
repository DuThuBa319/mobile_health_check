import 'package:mobile_health_check/common/service/onesginal/onesignal_service.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/presentation/common_widget/assets.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:mobile_health_check/presentation/modules/setting_screen/widget_setting.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../classes/language.dart';
import '../../../../function.dart';
import '../../../common_widget/common_button.dart';

import '../../../route/route_list.dart';
import '../../../theme/app_text_theme.dart';
import '../../../theme/theme_color.dart';

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
            onPressed: () => Navigator.pushNamed(context, RouteList.patientList,
                arguments: userDataData.getUser()!.id!),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: SingleChildScrollView(
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
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        shape: BoxShape.circle),
                    height: SizeConfig.screenWidth * 0.25,
                    width: SizeConfig.screenWidth * 0.25,
                    child: ClipRect(
                        child: Image.asset(
                      Assets.doctor,
                      fit: BoxFit.fill,
                    )),
                  ),
                  Text("Dr. ${userDataData.getUser()?.name}",
                      style: AppTextTheme.body0.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenWidth * 0.07)),
                  Text(userDataData.getUser()?.phoneNumber ?? '--',
                      style: AppTextTheme.body3),
                  SizedBox(height: SizeConfig.screenWidth * 0.05),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteList.settingDrPassword),
                    child: settingMenuCell(
                        translation(context).updatePassword, context),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteList.settingDrPhone),
                    child: settingMenuCell(
                        translation(context).updatePhoneNumber, context),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteList.settingLanguage),
                    child:
                        settingMenuCell(translation(context).language, context),
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.01),
                  CommonButton(
                      height: SizeConfig.screenHeight * 0.07,
                      title: translation(context).logOut,
                      buttonColor: AppColor.saveSetting,
                      onTap: () async {
                        OneSignalNotificationService
                            .unsubscribeFromNotifications(
                                doctorId: userDataData.getUser()!.id!);
                        await notificationData.clearData();
                        await userDataData.clearData();
                        await firebaseAuthService.signOut();
                        await OneSignal.logout();

                        // ignore: use_build_context_synchronously
                        // Navigator.pushReplacement(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return BlocProvider<LoginBloc>(
                        //       create: (context) => LoginBloc(),
                        //       child: const LoginScreen(),
                        //     );
                        //   },
                        // ));
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteList.login, (Route<dynamic> route) => false);
                      })
                ]),
          ),
        ));
  }
}
