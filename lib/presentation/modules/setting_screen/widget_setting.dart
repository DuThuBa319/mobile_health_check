// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:flutter/material.dart';
import 'package:mobile_health_check/function.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../theme/app_text_theme.dart';

Widget settingMenuCell(String selectSetting, BuildContext context) {
  SizeConfig.init(context);
  return Container(
    height: SizeConfig.screenWidth * 0.2,
    width: SizeConfig.screenWidth * 0.9,
    margin: EdgeInsets.only(
        top: SizeConfig.screenWidth * 0.035,
        bottom: SizeConfig.screenWidth * 0.035),
    decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
        boxShadow: [
          BoxShadow(
            blurRadius: SizeConfig.screenWidth * 0.035,
            color: Colors.black12,
          )
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            width: 10,
          ),
          selectSetting == "Cập nhật mật khẩu"
              ? const Icon(
                  Icons.lock_outline_rounded,
                  size: 38,
                )
              : selectSetting == "Cập nhật số điện thoại"
                  ? const Icon(Icons.account_box_rounded, size: 38)
                  : const Icon(Icons.language, size: 38),
          const SizedBox(
            width: 10,
          ),
          Text(selectSetting,
              style: AppTextTheme.body1
                  .copyWith(fontSize: SizeConfig.screenWidth * 0.06)),
        ]),
        const Icon(Icons.arrow_forward_ios_rounded, size: 30),
      ],
    ),
  );
}

///
Widget settingPhoneCell(String? selectSetting, BuildContext context) {
  SizeConfig.init(context);
  String phone = "";
  final phoneController = TextEditingController();
  return Container(
    height: SizeConfig.screenWidth * 0.2,
    width: SizeConfig.screenWidth * 0.9,
    margin: EdgeInsets.only(
        top: SizeConfig.screenWidth * 0.035,
        bottom: SizeConfig.screenWidth * 0.035),
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        width: SizeConfig.screenWidth * 0.04,
      ),
      SizedBox(
        width: SizeConfig.screenWidth * 0.8,
        child: TextField(
          textAlign: TextAlign.start,
          onChanged: (newphone) {
            phone = newphone;
          },
          cursorColor: AppColor.black,
          controller: phoneController,
          style: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.03, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: selectSetting,
            icon: Icon(Icons.account_box_rounded,
                size: SizeConfig.screenWidth * 0.1),
            labelStyle: TextStyle(
                color: AppColor.gray767676,
                fontSize: SizeConfig.screenWidth * 0.05),
          ),
        ),
      ),
      // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
    ]),
  );
}

//

// ignore: must_be_immutable
class SettingPasswordCell extends StatefulWidget {
  final String? selectSetting;

  bool showPass;
  SettingPasswordCell(
      {Key? key, required this.selectSetting, required this.showPass})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingPasswordCellState createState() => _SettingPasswordCellState();
}

class _SettingPasswordCellState extends State<SettingPasswordCell> {
  String pass = "";
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.screenWidth * 0.035,
          bottom: SizeConfig.screenWidth * 0.035),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: SizeConfig.screenWidth * 0.035,
            color: Colors.black12,
          )
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.035),
      ),
      height: SizeConfig.screenWidth * 0.2,
      width: SizeConfig.screenWidth * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: SizeConfig.screenWidth * 0.02,
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.8,
              child: TextField(
                obscureText: widget.showPass,
                textAlign: TextAlign.start,
                onChanged: (newPass) {
                  pass = newPass;
                },
                cursorColor: AppColor.black,
                controller: passController,
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.04,
                    color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        widget.showPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: SizeConfig.screenWidth * 0.05),
                    onPressed: () {
                      setState(() {
                        widget.showPass = !widget.showPass;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  hintText: widget.selectSetting,
                  icon: Icon(Icons.lock_outline_rounded,
                      size: SizeConfig.screenWidth * 0.1),
                  labelStyle: TextStyle(
                      color: AppColor.gray767676,
                      fontSize: SizeConfig.screenWidth * 0.06),
                ),
              ),
            ),

            // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
          ]),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

