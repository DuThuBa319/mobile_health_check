import 'package:mobile_health_check/function.dart';
import 'package:mobile_health_check/presentation/common_widget/dialog/show_toast.dart';
import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';

import '../../../../classes/language.dart';
import '../../../../common/singletons.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/line_decor.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';

class SettingDrOrRePhoneNumber extends StatefulWidget {
  const SettingDrOrRePhoneNumber({super.key});

  @override
  State<SettingDrOrRePhoneNumber> createState() =>
      _SettingDrOrRePhoneNumberState();
}

class _SettingDrOrRePhoneNumberState extends State<SettingDrOrRePhoneNumber> {
  final TextEditingController _controllerOldPhoneNumber =
      TextEditingController();
  final TextEditingController _controllerNewPhoneNumber =
      TextEditingController();

  bool showOldPhonen = true;
  bool showNewPhoneNumber = true;

  final passController = TextEditingController();
  String pass = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return CustomScreenForm(
        isRelativeApp:
            (userDataData.getUser()?.role == "relative") ? true : false,
        title: translation(context).updatePhoneNumber,
        isShowRightButon: false,
        isShowAppBar: true,
        isShowBottomNayvigationBar: false,
        isShowLeadingButton: true,
        appBarColor: AppColor.topGradient,
        backgroundColor: AppColor.backgroundColor,
        leadingButton: IconButton(
            onPressed: () => Navigator.pushNamed(context, RouteList.setting),
            icon: const Icon(Icons.arrow_back)),
        selectedIndex: 2,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.06,
                right: SizeConfig.screenWidth * 0.06),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  lineDecor(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Container(
                    height: SizeConfig.screenWidth * 0.2,
                    width: SizeConfig.screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.02,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.85,
                          child: TextField(
                            // focusNode: _focusNode,
                            controller: _controllerOldPhoneNumber,
                            obscureText: showOldPhonen,
                            style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    showOldPhonen
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: SizeConfig.screenWidth * 0.05),
                                onPressed: () {
                                  setState(() {
                                    showOldPhonen = !showOldPhonen;
                                  });
                                },
                              ),
                              icon: Icon(Icons.account_box_rounded,
                                  size: SizeConfig.screenWidth * 0.1),
                              border: InputBorder.none,
                              labelText: translation(context).oldPhoneNumber,
                              labelStyle: TextStyle(
                                  color: AppColor.gray767676,
                                  fontSize: SizeConfig.screenWidth * 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Container(
                    height: SizeConfig.screenWidth * 0.2,
                    width: SizeConfig.screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.02,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.85,
                          child: TextField(
                            // focusNode: _focusNode,
                            controller: _controllerNewPhoneNumber,
                            obscureText: showNewPhoneNumber,
                            style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.05,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                    showNewPhoneNumber
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: SizeConfig.screenWidth * 0.05),
                                onPressed: () {
                                  setState(() {
                                    showNewPhoneNumber = !showNewPhoneNumber;
                                  });
                                },
                              ),
                              icon: Icon(Icons.account_box_rounded,
                                  size: SizeConfig.screenWidth * 0.1),
                              border: InputBorder.none,
                              labelText: translation(context).newPhoneNumber,
                              labelStyle: TextStyle(
                                  color: AppColor.gray767676,
                                  fontSize: SizeConfig.screenWidth * 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Center(
                    child: CommonButton(
                        height: SizeConfig.screenHeight * 0.07,
                        title: translation(context).save,
                        buttonColor: AppColor.saveSetting,
                        onTap: () {
                          // firebaseAuthService.changePhoneNumber(
                          //     currentPhoneNumber: _controllerOldPhoneNumber.text,
                          //     newPhoneNumber: _controllerNewPhoneNumber.text);
                          showToast(translation(context)
                              .updatePhoneNumberSuccessfullly);
                          Navigator.pushNamed(context, RouteList.setting);
                        }),
                  )
                ]),
          ),
        ));
  }
}
